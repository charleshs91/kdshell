#!/bin/bash

APT_INSTALLS=(
  bat
  eza
  fzf
  fuse
  ripgrep
  fd-find
  btop
  wget
)

apt_install() {
  APT_INSTALLS_STRING=${APT_INSTALLS[*]}
  echo "Installing tools: ${APT_INSTALLS_STRING}"

  sudo apt update
  sudo apt install $APT_INSTALLS_STRING
}

append_line_if_missing() {
  local line="$1"
  grep -qxF "$line" "$SHELL_CONFIG_FILE" || echo "$line" >> "$SHELL_CONFIG_FILE"
}

install_neovim() {
  mkdir -p ~/.local/bin
  wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
  chmod u+x ./nvim-linux-x86_64.appimage
  mv ./nvim-linux-x86_64.appimage ~/.local/bin/nvim
}

install_mise() {
  if ! command -v mise > /dev/null 2>&1; then
    sudo apt update -y && sudo apt install -y curl
    sudo install -dm 755 /etc/apt/keyrings
    curl -fSs https://mise.jdx.dev/gpg-key.pub | sudo tee /etc/apt/keyrings/mise-archive-keyring.asc 1> /dev/null
    echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.asc] https://mise.jdx.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list
    sudo apt update -y
    sudo apt install -y mise

    append_line_if_missing 'eval "$(/usr/bin/mise activate bash)"'
  fi
}

install_atuin() {
  if ! command -v atuin > /dev/null 2>&1; then
    # bash-preexec: required for using atuin in bash.
    curl https://raw.githubusercontent.com/rcaloras/bash-preexec/master/bash-preexec.sh -o ~/.bash-preexec.sh
    append_line_if_missing '[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh'
    # Install atuin
    curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
    atuin import bash
  fi
}

install_zoxide() {
  if ! command -v zoxide > /dev/null 2>&1; then
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
    # export PATH='$HOME/.local/bin:$PATH'
  fi
}

main() {
  SHELL_CONFIG_FILE=~/.bashrc

  # Source - https://stackoverflow.com/a/246128
  SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

  # Preserve any existing shell config and only add our source line once.
  touch "$SHELL_CONFIG_FILE"

  apt_install
  install_neovim
  install_mise
  install_atuin
  install_zoxide

  CUSTOM_CONFIG_FILENAME="bash_config.sh"
  SOURCE_LINE="source ${SCRIPT_DIR}/${CUSTOM_CONFIG_FILENAME}"
  append_line_if_missing "$SOURCE_LINE"

  . "$SHELL_CONFIG_FILE"
}

main
