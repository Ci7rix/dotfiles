# Eval
eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(starship init zsh)"
eval "$(mise activate zsh)"

# Zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Tmux
zstyle ':prezto:module:tmux:auto-start' local 'yes'
zstyle ':prezto:module:tmux:session' name 'default'

# SSH
zstyle ':prezto:module:ssh:load' identities 'id_unset' 'id_yena'

# Utility
zstyle ':prezto:module:utility:ls' color 'yes'

# Various modules
zinit snippet PZTM::environment
zinit snippet PZTM::history
zinit snippet PZTM::directory
zinit snippet PZTM::spectrum
zinit snippet PZTM::gnu-utility
zinit snippet PZTM::utility
zinit snippet PZTM::helper
zinit snippet PZTM::tmux
zinit snippet PZTM::macports
zinit snippet PZTM::homebrew
zinit snippet PZTM::completion
zinit snippet PZTM::ssh

# zsh-syntax-highlighting
zinit snippet 'https://github.com/catppuccin/zsh-syntax-highlighting/blob/main/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh'
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions

# zsh-history-substring-search
zinit light zsh-users/zsh-history-substring-search
zinit ice wait lucid atload'__bind_history_keys'
function __bind_history_keys() {
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
}
