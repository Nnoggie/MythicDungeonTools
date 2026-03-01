# MethodInternal Agent Rules

Before any action, check and read ./AGENTS.local.md if it exists.
If `AGENTS.local.md` exists, apply those rules in addition to this file. Keep `AGENTS.local.md` user-specific and uncommitted.

## Release Workflow

Use this workflow when asked to "bump version and release" or "push a release":

1. Read current version in `MythicDungeonTools.toc` (`## Version:`) and `CHANGELOG.txt`.
2. Bump `MythicDungeonTools.toc` to the next requested version.
3. Update `CHANGELOG.txt` for that version using today's date (`YYYY-MM-DD`).
4. Keep only the current version entry in `CHANGELOG.txt` (remove older version sections).
5. Commit version/changelog changes on `master`.
6. Create an annotated tag that matches the version exactly (example: `1.0.2`).
7. Push `master` and push the tag to `origin`.

Notes:

- GitHub release packaging is triggered by tag push via `.github/workflows/release.yml` (`on.push.tags: '**'`).
- Prefer tag format without `v` prefix unless explicitly requested.
