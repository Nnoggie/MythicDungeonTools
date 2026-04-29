#!/usr/bin/env bash
set -euo pipefail

project_id="${CF_PROJECT_ID:-288981}"
namespace="${CF_LOCALIZATION_NAMESPACE:-MDT}"
wait_seconds="${CF_LOCALIZATION_WAIT_SECONDS:-90}"
poll_interval="${CF_LOCALIZATION_POLL_INTERVAL:-10}"
api_base="${CF_LOCALIZATION_API_BASE:-https://legacy.curseforge.com/api/projects/${project_id}/localization}"
locales=(
  "enUS|Locales/enUS.lua|DoNothing"
  "zhCN|Locales/zhCN.lua|DoNothing"
)

if [[ -z "${CF_API_KEY:-}" ]]; then
  echo "CF_API_KEY is required to update CurseForge localizations." >&2
  exit 1
fi

tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

import_locale() {
  local language="$1"
  local source_file="$2"
  local missing_phrase_handling="$3"
  local localizations="$tmpdir/${language}.lua"
  local keys="$tmpdir/${language}.keys"
  local response="$tmpdir/${language}-import-response.json"
  local export_file="$tmpdir/${language}-export.lua"

  python3 scripts/extract_localizations.py --source "$source_file" --language "$language" --output "$localizations" --keys "$keys"
  local key_count
  key_count="$(wc -l < "$keys" | tr -d ' ')"
  local metadata
  metadata="{\"language\":\"${language}\",\"namespace\":\"${namespace}\",\"formatType\":\"TableAdditions\",\"missing-phrase-handling\":\"${missing_phrase_handling}\"}"

  echo "Importing ${key_count} ${language} localization keys to CurseForge project ${project_id}..."
  local status
  status="$(
    curl -sS -0 -X POST -w "%{http_code}" -o "$response" \
      -H "X-Api-Token: ${CF_API_KEY}" \
      -F "metadata=${metadata}" \
      -F "localizations=<${localizations}" \
      "${api_base}/import"
  )"

  if [[ "$status" != "200" ]]; then
    echo "CurseForge ${language} localization import failed with HTTP ${status}." >&2
    [[ -s "$response" ]] && cat "$response" >&2
    exit 1
  fi

  echo "Import accepted. Waiting for CurseForge ${language} export to include uploaded keys..."
  local deadline=$((SECONDS + wait_seconds))
  local export_url="${api_base}/export?export-type=TableAdditions&lang=${language}&unlocalized=ShowPrimary&table-name=L&namespaces=${namespace}&escape-non-ascii-characters=false&true-if-value-equals-key=false"

  while true; do
    curl -fsS -H "X-Api-Token: ${CF_API_KEY}" "$export_url" -o "$export_file"
    if python3 scripts/extract_localizations.py --source "$source_file" --language "$language" --check-export "$export_file" --keys "$keys"; then
      echo "CurseForge ${language} localizations synced."
      return
    fi

    if (( SECONDS >= deadline )); then
      echo "Timed out waiting for CurseForge ${language} localizations to sync." >&2
      exit 1
    fi

    sleep "$poll_interval"
  done
}

for locale_info in "${locales[@]}"; do
  IFS="|" read -r language source_file missing_phrase_handling <<< "$locale_info"
  import_locale "$language" "$source_file" "$missing_phrase_handling"
done
