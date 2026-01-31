#
eval "$(/opt/homebrew/bin/brew shellenv)"

# enable powerlevel10k zsh theme
# https://github.com/romkatv/powerlevel10k
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

alias vim="nvim"

# editor
export EDITOR=nvim

# key repeat
defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)

# inform SSH how to speak with GPG
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# zsh auto complete plugin
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

bindkey '<Tab>' accept-line
bindkey '\e' kill-line

# zsh syntax highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zoxide is a better cd
eval "$(zoxide init zsh)"
alias cd="z"

# Eza is a better ls
alias ls="eza --icons=always"
alias ll="ls -la --group-directories-first"
alias lt="ls -lDT"

# Aliases
alias dock="docker compose"

alias pgstage="sh ~/luminary/scripts/connect-staging"
alias pgprod="sh ~/luminary/scripts/connect-prod"

## API testing
alias authLocal='export ACCESS_TOKEN="$("$HOME/luminary/api-testing/local/auth.sh" | jq -r .access_token)"'
