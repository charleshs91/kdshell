#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
REPO_DIR=$(cd -- "${SCRIPT_DIR}/.." &> /dev/null && pwd)

if ! command -v stow > /dev/null 2>&1; then
  echo "Error: GNU stow is required. Install it first, e.g. sudo apt install stow" >&2
  exit 1
fi

stow --dir="${REPO_DIR}/dotfiles" --target="${HOME}" neovim

echo "Neovim configuration symlinked from ${REPO_DIR}/dotfiles/neovim to ${HOME}"
