# **Action Library Create Log**

| **Home**
| [Changelog](./CHANGELOG.md)
| [Contributing](./CONTRIBUTING.md)
| [Tech Doc](./techdoc.md)
| <!-- End Of Menu -->

---

Creates log files from PR content using the VERSION file(s) affected by the change.

## Overview

This composite action reads the PR body and writes a log entry named after the current VERSION. It supports root VERSION files and feature-scoped VERSION files, and skips documentation-only changes.

## Behavior Summary

- Uses the PR body as log content (no parsing).
- Adds a header with release link, PR link, and labels.
- Appends PR details (author, merge, reviewers, file stats) inside the existing details block.
- Writes logs as `logs/<version>.md`.
- Supports VERSION values with an optional leading `v` (preserved in log file names).
- If a root `VERSION` exists, logs are created at repo root.
- Otherwise, VERSION files are discovered from non-doc PR file paths and logs are created per feature.
- Skips log creation when only `*.md` or `.github/*` files are changed.
- Commits newly created log files but does not push them.

## Inputs

| Name | Required | Description |
| --- | --- | --- |
| `pr_number` | No | PR number used to read body and changed files. |
| `github_token` | No | GitHub token for API access (defaults to `GITHUB_TOKEN`). |
| `version_file` | No | Preferred VERSION file path (optional). |
| `release_version` | No | Deprecated. Version is read from VERSION file(s). |

## Output Format

Each log file is written as:

```md
## <version>

**Release:** [<feature> <version>](https://github.com/<org>/<repo>/releases/tag/<feature>-<version>)
**PR:** [<PR Title> (#<PR Number>)](https://github.com/<org>/<repo>/pull/<PR Number>)
**Labels:** <label1>, <label2>

<PR body, with PR Details appended inside the existing details block>
```

## Version Discovery Rules

Order of precedence:

1. `version_file` input if provided and exists.
2. Root `./VERSION` if present.
3. Walk parent directories of each non-doc changed file and collect all VERSION files found.

## Permissions

- `contents: write` is required to commit log files.
- `pull-requests: read` is required to read PR body and file list.

## Requirements

- Repository must be checked out before running.
- `gh` CLI, `git`, and `jq` are required (present on GitHub-hosted runners).
- `python` (for PR details insertion).

## Usage

```yaml
- uses: actions/checkout@v4
- name: Create Log
  uses: Technolog-Ltd/ActionLib-Create-Log@main
  with:
    pr_number: ${{ steps.lookup.outputs.pr_number }}
```

## Notes

- If a log file already exists for the version, it is not overwritten.
- Use the changelog action to push all commits after logs are created.

---

<p style="text-align: center;"><a href="#">Return to Top</a></p>

<h6 style="text-align: center;">Copyright &copy; Technolog Ltd</h6>
