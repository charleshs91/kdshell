# Agent Guide

This repository contains shell setup scripts for Debian-based LXCs.

## Project layout

- `debian/install.sh` installs packages/tools and wires shell config.
- `debian/bash_config.sh` is sourced from `~/.bashrc` and initializes optional tools.
- `debian/aliases.sh` defines interactive shell aliases.
- `lib/common.sh` holds shared shell helpers when needed.

## Editing guidelines

- Keep scripts safe to rerun on many existing containers.
- Do not overwrite user files such as `~/.bashrc`; append only when needed and avoid duplicate lines.
- Prefer guarded setup: check commands/files before sourcing, aliasing, or initializing tools.
- Quote paths and variables unless intentional word splitting is required.
- Follow `.editorconfig`: shell scripts use 2 spaces, LF endings, and final newlines.

## Validation

Before committing, run at least:

```bash
bash -n debian/*.sh lib/*.sh
```

If changing install behavior, review the diff carefully for destructive operations (`mv`, `rm`, redirects to user config files).
