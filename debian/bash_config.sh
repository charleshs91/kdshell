#!/usr/bin/env bash

script_dir() {
  cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd
}

source_if_exists() {
  [[ -f $1 ]] && source "$1"
}

prepend_path() {
  case ":$PATH:" in
    *":$1:"*) ;;
    *) PATH="$1${PATH:+:$PATH}" ;;
  esac
}

KDSHELL_DIR="$(script_dir)"

# Atuin
source_if_exists "$HOME/.atuin/bin/env"
if command -v atuin >/dev/null 2>&1; then
  eval "$(atuin init bash --disable-up-arrow)"
fi

source_if_exists "$HOME/.bash-preexec.sh"

# zoxide
prepend_path "$HOME/.local/bin"
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init --cmd j bash)"
fi

# mise
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate bash)"
fi

# custom aliases
source_if_exists "$KDSHELL_DIR/aliases.sh"
