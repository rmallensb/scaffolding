# Homebrew — detect platform
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

BREW_PREFIX="$(brew --prefix 2>/dev/null || true)"

# enable powerlevel10k zsh theme
# https://github.com/romkatv/powerlevel10k
[[ -f "$BREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme" ]] && \
  source "$BREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme"

alias vim="nvim"

# editor
export EDITOR=nvim

# key repeat (macOS only)
if [[ "$(uname)" == "Darwin" ]]; then
  defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
  defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
fi

# GPG agent for SSH auth (macOS only — on Linux devboxes, use forwarded agent)
# NOTE: hardcoded to macOS because WezTerm sets SSH_AUTH_SOCK to its own empty
# agent, so we need to unconditionally override it with the GPG agent locally.
# If we ever need GPG agent on a Linux host, revisit this condition.
if [[ "$(uname)" == "Darwin" ]]; then
  export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  gpgconf --launch gpg-agent
fi

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
[[ -f "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && \
  source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

bindkey '<Tab>' accept-line
bindkey '\e' kill-line

# zsh syntax highlighting
[[ -f "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && \
  source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

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
