#Requires -Version 7.0
[CmdletBinding()]
param(
  [string]$RepoRoot = (Split-Path $PSScriptRoot -Parent),
  [switch]$SelfTest
)

$ErrorActionPreference = 'Stop'
$PSNativeCommandUseErrorActionPreference = $false
$ProgressPreference = 'SilentlyContinue'
$repoPath = (Resolve-Path -LiteralPath $RepoRoot).Path
$toolRoot = Join-Path $repoPath '.luals'
New-Item -ItemType Directory -Path $toolRoot -Force | Out-Null

function Install-CheckDependency($Name, $Url, $Sha256, $RequiredPath) {
  $destination = Join-Path $toolRoot $Name
  $marker = Join-Path $destination '.verified-sha256'
  $required = Join-Path $destination $RequiredPath
  if ((Test-Path -LiteralPath $marker) -and (Test-Path -LiteralPath $required) -and
      (Get-Content -LiteralPath $marker -Raw).Trim() -eq $Sha256) {
    return $destination
  }
  $archive = Join-Path $toolRoot "$Name.zip"
  Write-Host "Downloading $Name"
  Invoke-WebRequest -Uri $Url -OutFile $archive
  if ((Get-FileHash -LiteralPath $archive -Algorithm SHA256).Hash -ne $Sha256) {
    throw "Checksum mismatch for $Name"
  }
  Expand-Archive -LiteralPath $archive -DestinationPath $destination -Force
  if (-not (Test-Path -LiteralPath $required)) { throw "$Name is missing $RequiredPath" }
  Set-Content -LiteralPath $marker -Value $Sha256 -Encoding utf8
  return $destination
}

function Escape-Annotation([string]$Text) {
  return $Text.Replace('%', '%25').Replace("`r", '%0D').Replace("`n", '%0A').Replace(',', '%2C').Replace(':', '%3A')
}

try {
  if (-not $IsWindows) { throw 'Run this check with PowerShell 7 on Windows, as in GitHub CI.' }
  $serverRoot = Install-CheckDependency 'lua-language-server-3.19.1' `
    'https://github.com/LuaLS/lua-language-server/releases/download/3.19.1/lua-language-server-3.19.1-win32-x64.zip' `
    'fdb9a59108cf62517813c97fa5549b0e16d1ef0688306bac728b08434db7e4cd' 'bin/lua-language-server.exe'
  $null = Install-CheckDependency 'wow-api-0.22.3' `
    'https://github.com/Ketho/vscode-wow-api/releases/download/0.22.3/wow-api-0.22.3.vsix' `
    '23291e63941bdf1aec292401eeba6e384842916f56a71b4d799a4dc7bf823fdc' 'extension/Annotations/Core'
  $server = Join-Path $serverRoot 'bin/lua-language-server.exe'
  if ($SelfTest) {
    # Expected failures belong to the self-test, not GitHub's annotations or summary.
    $env:GITHUB_ACTIONS = 'false'
    $env:GITHUB_STEP_SUMMARY = ''
    $fixture = Join-Path $toolRoot ('self-test-' + [Guid]::NewGuid().ToString('N'))
    New-Item -ItemType Directory -Path "$fixture/scripts", "$fixture/.luals" -Force | Out-Null
    foreach ($dependency in @('lua-language-server-3.19.1', 'wow-api-0.22.3')) {
      New-Item -ItemType Junction -Path "$fixture/.luals/$dependency" -Target (Join-Path $toolRoot $dependency) | Out-Null
    }
    Copy-Item -LiteralPath "$repoPath/.luarc.json" -Destination "$fixture/.luarc.json"
    Set-Content -LiteralPath "$fixture/check.lua" -Value 'C_Timer.After(1, function() end)'
    Set-Content -LiteralPath "$fixture/scripts/check.lua" -Value 'return io.open("test.txt", "r")'
    & pwsh -NoProfile -File $PSCommandPath -RepoRoot $fixture
    if ($LASTEXITCODE -ne 0) { throw 'Self-test: clean addon and CLI scripts must pass.' }
    $fixtureConfig = Get-Content "$fixture/.luarc.json" -Raw | ConvertFrom-Json -AsHashtable
    $fixtureConfig['diagnostics.severity']['unused-local'] = 'Hint!'
    $fixtureConfig | ConvertTo-Json -Depth 10 | Set-Content "$fixture/.luarc.json"
    Set-Content "$fixture/check.lua" -Value 'local unused = 1'
    Set-Content "$fixture/scripts/check.lua" -Value 'local unused = 1'
    & pwsh -NoProfile -File $PSCommandPath -RepoRoot $fixture
    $hintExit = $LASTEXITCODE
    $hintReport = @(Get-Content "$fixture/.luals/report.json" -Raw | ConvertFrom-Json)
    if ($hintExit -ne 1 -or $hintReport.Count -ne 2 -or @($hintReport | Where-Object Severity -ne 4).Count -gt 0 -or
        'check.lua' -notin $hintReport.File -or 'scripts/check.lua' -notin $hintReport.File) {
      throw 'Self-test: root diagnostic rules must apply to both scopes, and hints must fail with correct paths.'
    }
    Set-Content "$fixture/check.lua" -Value 'C_Timer.After("wrong type", function() end)'
    Set-Content "$fixture/scripts/check.lua" -Value 'return missing_script_global'
    & pwsh -NoProfile -File $PSCommandPath -RepoRoot $fixture
    $failureExit = $LASTEXITCODE
    $failureReport = @(Get-Content "$fixture/.luals/report.json" -Raw | ConvertFrom-Json)
    if ($failureExit -ne 1 -or 'param-type-mismatch' -notin $failureReport.Code -or 'scripts/check.lua' -notin $failureReport.File) {
      throw 'Self-test: WoW argument types and the separate CLI workspace must be checked.'
    }
    Set-Content "$fixture/check.lua" -Value 'C_Timer.After(1, function() end)'
    Set-Content "$fixture/scripts/check.lua" -Value 'return io.open("test.txt", "r")'
    Set-Content "$fixture/.luarc.json" -Value 'invalid JSON'
    $invalidOutput = & pwsh -NoProfile -File $PSCommandPath -RepoRoot $fixture 2>&1
    if ($LASTEXITCODE -ne 1) { throw "Self-test: invalid configuration must fail. $invalidOutput" }
    Write-Host 'LuaLS runner self-test passed.'
    exit 0
  }
  $diagnostics = @()
  # CLI tooling has standard Lua libraries; addon code uses the WoW replacements.
  foreach ($scope in @('addon', 'scripts')) {
    $workspace = if ($scope -eq 'addon') { $repoPath } else { Join-Path $repoPath 'scripts' }
    $configPath = Join-Path $repoPath '.luarc.json'
    if (-not (Test-Path -LiteralPath $configPath)) { throw "Missing config: $configPath" }
    $config = Get-Content -LiteralPath $configPath -Raw | ConvertFrom-Json -AsHashtable -NoEnumerate
    if ($config -isnot [System.Collections.IDictionary]) { throw "Invalid config: $configPath" }
    $runPath = Join-Path $toolRoot ("reports/$scope-" + [Guid]::NewGuid().ToString('N'))
    New-Item -ItemType Directory -Path $runPath -Force | Out-Null
    if ($scope -eq 'scripts') {
      # Keep the root diagnostic policy; only switch from WoW to the CLI environment.
      $config.Remove('runtime.builtin')
      $config['workspace.library'] = @()
      $config['workspace.ignoreDir'] = @($config['workspace.ignoreDir'] | Where-Object { $_ -ne 'scripts' })
      $configPath = Join-Path $runPath 'config.json'
      ConvertTo-Json -InputObject $config -Depth 20 | Set-Content -LiteralPath $configPath -Encoding utf8
    }
    $reportPath = Join-Path $runPath 'report.json'
    $nativeOutput = & $server "--check=$workspace" '--checklevel=Hint' '--check_format=json' `
      "--configpath=$configPath" "--check_out_path=$reportPath" "--logpath=$runPath" 2>&1
    $serverExitCode = $LASTEXITCODE
    $nativeOutput | Set-Content -LiteralPath (Join-Path $runPath 'output.txt') -Encoding utf8
    if ($serverExitCode -notin @(0, 1) -or -not (Test-Path -LiteralPath $reportPath)) {
      throw "LuaLS failed for $scope (exit $serverExitCode); see $runPath"
    }
    $report = Get-Content -LiteralPath $reportPath -Raw | ConvertFrom-Json -AsHashtable -NoEnumerate
    if ($report -is [array]) {
      if ($report.Count -ne 0) { throw "Unexpected LuaLS report in $reportPath" }
      continue
    }
    if ($report -isnot [System.Collections.IDictionary]) { throw "Invalid LuaLS report in $reportPath" }
    foreach ($uri in $report.Keys) {
      $localPath = ([Uri]$uri).LocalPath -replace '^/([A-Za-z]:/)', '$1'
      $relativePath = [IO.Path]::GetRelativePath($repoPath, $localPath).Replace('\', '/')
      foreach ($diagnostic in $report[$uri]) {
        $diagnostics += [PSCustomObject]@{
          File = $relativePath
          Line = [int]$diagnostic.range.start.line + 1
          Character = [int]$diagnostic.range.start.character + 1
          Severity = [int]$diagnostic.severity
          Code = [string]$diagnostic.code
          Message = ([string]$diagnostic.message -replace '\r?\n', ' ')
        }
      }
    }
  }
  $diagnostics = @($diagnostics | Sort-Object File, Line, Character, Code)
  $jsonPath = Join-Path $toolRoot 'report.json'
  ConvertTo-Json -InputObject $diagnostics -Depth 10 | Set-Content -LiteralPath $jsonPath -Encoding utf8
  $fileCount = @($diagnostics.File | Sort-Object -Unique).Count
  $errorCount = @($diagnostics | Where-Object Severity -eq 1).Count
  $summary = "LuaLS 3.19.1: $($diagnostics.Count) diagnostics in $fileCount files ($errorCount errors); check level Hint."
  $header = @('# LuaLS report', '', $summary, '', '## Diagnostic counts', '')
  $header += $diagnostics | Group-Object Code | Sort-Object Count -Descending | ForEach-Object { "- $($_.Name): $($_.Count)" }
  $markdown = @($header)
  $markdown += @('', '## Locations', '')
  $markdown += $diagnostics | ForEach-Object { '- {0}:{1}:{2} [{3}] {4}' -f $_.File, $_.Line, $_.Character, $_.Code, $_.Message }
  $markdownPath = Join-Path $toolRoot 'report.md'
  $markdown | Set-Content -LiteralPath $markdownPath -Encoding utf8
  if ($env:GITHUB_STEP_SUMMARY) {
    @($header) + @('', 'Full locations and native LuaLS reports are available in the `luals-report` artifact.') |
      Add-Content -LiteralPath $env:GITHUB_STEP_SUMMARY -Encoding utf8
  }
  if ($env:GITHUB_ACTIONS -eq 'true') {
    foreach ($diagnostic in $diagnostics) {
      $kind = switch ($diagnostic.Severity) { 1 { 'error' } 2 { 'warning' } default { 'notice' } }
      $file = Escape-Annotation $diagnostic.File
      $message = Escape-Annotation "[$($diagnostic.Code)] $($diagnostic.Message)"
      Write-Host "::$kind file=$file,line=$($diagnostic.Line),col=$($diagnostic.Character)::$message"
    }
  }
  Write-Host $summary
  Write-Host "Report: $markdownPath"
  if ($diagnostics.Count -gt 0) { exit 1 }
  exit 0
} catch {
  Write-Host "::error::$(Escape-Annotation $_.Exception.Message)"
  exit 1
}
