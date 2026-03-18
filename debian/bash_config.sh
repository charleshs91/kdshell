# Atuin
. "$HOME/.atuin/bin/env"
eval "$(atuin init bash --disable-up-arrow)"
[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh

# zoxide
export PATH="$HOME/.local/bin:$PATH"
eval "$(zoxide init --cmd j bash)"

# mise
eval "$(/usr/bin/mise activate bash)"

# custom aliases
source ~/kdshell/debian/aliases.sh
