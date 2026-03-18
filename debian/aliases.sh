setup_fdfind() {
  if command -v fdfind > /dev/null 2>&1; then
    alias fd='fdfind'
  fi
}

setup_ls() {
  if command -v eza > /dev/null 2>&1; then
    alias ls='eza'
  fi

  alias l='ls'
  alias la='ls -a'
  alias ll='ls -lh'
  alias lal='ls -lah'
}

setup_bat() {
  if command -v batcat > /dev/null 2>&1; then
    alias bat='batcat'
  fi
}

setup_lazygit() {
  if command -v lazygit > /dev/null 2>&1; then
    alias lg='lazygit'
  fi
}

setup_lazydocker() {
  if command -v lazydocker > /dev/null 2>&1; then
    alias lzd='lazydocker'
  fi
}

setup_bat
setup_fdfind
setup_ls
setup_lazygit
setup_lazydocker

alias c=clear
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
