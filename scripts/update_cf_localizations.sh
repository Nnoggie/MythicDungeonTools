#!/usr/bin/env bash
set -euo pipefail

project_id="${CF_PROJECT_ID:-288981}"
namespace="${CF_LOCALIZATION_NAMESPACE:-MDT}"
language="${CF_LOCALIZATION_LANGUAGE:-enUS}"
wait_seconds="${CF_LOCALIZATION_WAIT_SECONDS:-90}"
poll_interval="${CF_LOCALIZATION_POLL_INTERVAL:-10}"
api_base="${CF_LOCALIZATION_API_BASE:-https://legacy.curseforge.com/api/projects/${project_id}/localization}"

if [[ -z "${CF_API_KEY:-}" ]]; then
  echo "CF_API_KEY is required to update CurseForge localizations." >&2
  exit 1
fi

tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

localizations="$tmpdir/enUS.lua"
keys="$tmpdir/enUS.keys"
response="$tmpdir/import-response.json"
export_file="$tmpdir/export.lua"

python3 scripts/extract_enUS_localizations.py --output "$localizations" --keys "$keys"
key_count="$(wc -l < "$keys" | tr -d ' ')"
metadata="{\"language\":\"${language}\",\"namespace\":\"${namespace}\",\"formatType\":\"TableAdditions\",\"missing-phrase-handling\":\"DoNothing\"}"

echo "Importing ${key_count} ${language} localization keys to CurseForge project ${project_id}..."
status="$(
  curl -sS -0 -X POST -w "%{http_code}" -o "$response" \
    -H "X-Api-Token: ${CF_API_KEY}" \
    -F "metadata=${metadata}" \
    -F "localizations=<${localizations}" \
    "${api_base}/import"
)"

if [[ "$status" != "200" ]]; then
  echo "CurseForge localization import failed with HTTP ${status}." >&2
  [[ -s "$response" ]] && cat "$response" >&2
  exit 1
fi

echo "Import accepted. Waiting for CurseForge export to include uploaded keys..."
deadline=$((SECONDS + wait_seconds))
export_url="${api_base}/export?export-type=TableAdditions&lang=${language}&unlocalized=ShowPrimary&table-name=L&namespaces=${namespace}&escape-non-ascii-characters=false&true-if-value-equals-key=false"

while true; do
  curl -fsS -H "X-Api-Token: ${CF_API_KEY}" "$export_url" -o "$export_file"
  if python3 scripts/extract_enUS_localizations.py --check-export "$export_file" --keys "$keys"; then
    echo "CurseForge localizations synced."
    exit 0
  fi

  if (( SECONDS >= deadline )); then
    echo "Timed out waiting for CurseForge localizations to sync." >&2
    exit 1
  fi

  sleep "$poll_interval"
done
