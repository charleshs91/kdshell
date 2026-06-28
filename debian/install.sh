#!/bin/bash

APT_INSTALLS=(
  bat
  curl
  eza
  fzf
  liquidprompt
  fuse
  ripgrep
  fd-find
  btop
  wget
  stow
)

apt_install() {
  APT_INSTALLS_STRING=${APT_INSTALLS[*]}
  echo "Installing tools: ${APT_INSTALLS_STRING}"

  sudo apt update
  sudo apt install -y "${APT_INSTALLS[@]}"
}

append_line_if_missing() {
  local line="$1"

  if grep -qxF "$line" "$SHELL_CONFIG_FILE"; then
    return
  fi

  if [[ -s "$SHELL_CONFIG_FILE" && $(tail -c 1 "$SHELL_CONFIG_FILE") != "" ]]; then
    printf '\n' >> "$SHELL_CONFIG_FILE"
  fi

  printf '%s\n' "$line" >> "$SHELL_CONFIG_FILE"
}

install_neovim() {
  mise use -g tree-sitter

  if command -v nvim > /dev/null 2>&1 || [[ -x "$HOME/.local/bin/nvim" ]]; then
    return
  fi

  local tmp_file
  tmp_file=$(mktemp) || return

  local status

  if ! mkdir -p "$HOME/.local/bin"; then
    rm -f "$tmp_file"
    return 1
  fi

  if wget -O "$tmp_file" https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage; then
    install -m 755 "$tmp_file" "$HOME/.local/bin/nvim"
    status=$?
  else
    status=$?
  fi
  rm -f "$tmp_file"

  return "$status"
}

install_mise() {
  if ! command -v mise > /dev/null 2>&1; then
    sudo install -dm 755 /etc/apt/keyrings
    curl -fSs https://mise.jdx.dev/gpg-key.pub | sudo tee /etc/apt/keyrings/mise-archive-keyring.asc 1> /dev/null
    echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.asc] https://mise.jdx.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list
    sudo apt update -y
    sudo apt install -y mise
  fi
}

install_atuin() {
  if ! command -v atuin > /dev/null 2>&1; then
    # bash-preexec: required for using atuin in bash.
    curl https://raw.githubusercontent.com/rcaloras/bash-preexec/master/bash-preexec.sh -o "$HOME/.bash-preexec.sh"
    # Install atuin
    curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh

    if [[ -x "$HOME/.atuin/bin/atuin" ]]; then
      "$HOME/.atuin/bin/atuin" import bash
    elif command -v atuin > /dev/null 2>&1; then
      atuin import bash
    fi
  fi
}

install_zoxide() {
  if ! command -v zoxide > /dev/null 2>&1; then
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
    # export PATH='$HOME/.local/bin:$PATH'
  fi
}

main() {
  SHELL_CONFIG_FILE="$HOME/.bashrc"

  # Source - https://stackoverflow.com/a/246128
  SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

  # Preserve any existing shell config and only add our source line once.
  touch "$SHELL_CONFIG_FILE"

  apt_install
  install_mise
  install_neovim
  install_atuin
  install_zoxide

  CUSTOM_CONFIG_FILENAME="bash_config.sh"
  SOURCE_LINE="source \"${SCRIPT_DIR}/${CUSTOM_CONFIG_FILENAME}\""
  append_line_if_missing "$SOURCE_LINE"

  echo "Shell config updated. Restart your shell or run: source '$SHELL_CONFIG_FILE'"
}

main
