alias_if_exists() {
  command -v "$1" >/dev/null 2>&1 && alias "$2=$1"
}

setup_ls() {
  alias_if_exists eza ls

  alias l='ls'
  alias la='ls -a'
  alias ll='ls -lh'
  alias lal='ls -lah'
}

alias_if_exists batcat bat
alias_if_exists fdfind fd
alias_if_exists nvim v
alias_if_exists lazygit lg
alias_if_exists lazydocker lzd

setup_ls

alias c=clear
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
