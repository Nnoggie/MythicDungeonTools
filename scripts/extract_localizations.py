#!/usr/bin/env python3
import argparse
import re
import sys
from pathlib import Path


ENTRY_RE = re.compile(r'^\s*L\["([^"]+)"\]\s*=', re.MULTILINE)
LUA_ESCAPES = {
    "a": "\a",
    "b": "\b",
    "f": "\f",
    "n": "\n",
    "r": "\r",
    "t": "\t",
    "v": "\v",
    "\\": "\\",
    '"': '"',
    "'": "'",
}


def normalize_lua_key(key):
    normalized = []
    index = 0

    while index < len(key):
        char = key[index]
        if char != "\\" or index + 1 >= len(key):
            normalized.append(char)
            index += 1
            continue

        next_char = key[index + 1]
        if next_char in LUA_ESCAPES:
            normalized.append(LUA_ESCAPES[next_char])
            index += 2
            continue

        normalized.append(next_char)
        index += 2

    return "".join(normalized)


def display_key(key):
    return key.encode("unicode_escape").decode("ascii")


def extract_entries(source_path):
    lines = source_path.read_text(encoding="utf-8").splitlines()
    entries = []
    index = 0

    while index < len(lines):
        line = lines[index]
        if "@localization" in line:
            break

        match = ENTRY_RE.match(line)
        if not match:
            index += 1
            continue

        key = match.group(1)
        block = [line.rstrip()]
        index += 1

        while index < len(lines):
            next_line = lines[index]
            if "@localization" in next_line or ENTRY_RE.match(next_line):
                break
            block.append(next_line.rstrip())
            index += 1

        entries.append((key, block))

    return entries


def write_entries(entries, output_path, keys_path):
    output_path.write_text(
        "\n".join("\n".join(block) for _, block in entries) + "\n",
        encoding="utf-8",
    )
    keys_path.write_text(
        "\n".join(key for key, _ in entries) + "\n",
        encoding="utf-8",
    )


def check_export(export_path, keys_path, language):
    export_text = export_path.read_text(encoding="utf-8", errors="replace")
    exported_keys = {
        normalize_lua_key(key)
        for key in ENTRY_RE.findall(export_text)
    }
    expected_keys = [
        normalize_lua_key(line)
        for line in keys_path.read_text(encoding="utf-8").splitlines()
        if line
    ]
    skipped_keys = [
        key
        for key in expected_keys
        if "\n" in key
    ]
    expected_keys = [
        key
        for key in expected_keys
        if "\n" not in key
    ]
    missing = [key for key in expected_keys if key not in exported_keys]
    if missing:
        print(f"Missing {len(missing)} localization keys in CurseForge export.")
        for key in missing[:20]:
            print(f"  {display_key(key)}")
        return 1
    if skipped_keys:
        print(
            f"Skipped {len(skipped_keys)} {language} keys with embedded newlines; "
            "CurseForge export does not round-trip them."
        )
    print(f"CurseForge export contains {len(expected_keys)} checked {language} keys.")
    return 0


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--source", required=True)
    parser.add_argument("--language", default="localization")
    parser.add_argument("--output")
    parser.add_argument("--keys")
    parser.add_argument("--check-export")
    args = parser.parse_args()

    if args.check_export:
        if not args.keys:
            parser.error("--keys is required with --check-export")
        return check_export(Path(args.check_export), Path(args.keys), args.language)

    if not args.output or not args.keys:
        parser.error("--output and --keys are required")

    entries = extract_entries(Path(args.source))
    if not entries:
        print(f"No {args.language} localization entries found.", file=sys.stderr)
        return 1

    write_entries(entries, Path(args.output), Path(args.keys))
    print(f"Wrote {len(entries)} {args.language} localization entries.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
