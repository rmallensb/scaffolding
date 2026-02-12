#!/usr/bin/env bash
set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

info()  { echo -e "${GREEN}[INFO]${NC} $1"; }
warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

OS="$(uname -s)"
ARCH="$(uname -m)"

# ---------- Homebrew ----------

install_homebrew() {
  if command -v brew &>/dev/null; then
    info "Homebrew already installed"
  else
    info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add brew to current shell so the rest of the script works
    if [[ "$OS" == "Darwin" ]]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    else
      eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
  fi
}

# ---------- Packages ----------

install_packages() {
  info "Installing packages via Homebrew..."

  local packages=(
    neovim
    ripgrep
    fd
    eza
    zoxide
    zsh-autosuggestions
    zsh-syntax-highlighting
    powerlevel10k
    fzf
  )

  brew install "${packages[@]}"
}

# ---------- Oh My Zsh ----------

install_oh_my_zsh() {
  if [[ -d "$HOME/.oh-my-zsh" ]]; then
    info "Oh My Zsh already installed"
  else
    info "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  fi
}

# ---------- Zsh plugins (OMZ custom) ----------

install_zsh_plugins() {
  local ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

  if [[ -d "$ZSH_CUSTOM/plugins/zsh-vi-mode" ]]; then
    info "zsh-vi-mode already installed"
  else
    info "Installing zsh-vi-mode..."
    git clone https://github.com/jeffreytse/zsh-vi-mode "$ZSH_CUSTOM/plugins/zsh-vi-mode"
  fi
}

# ---------- Ensure zsh is default shell ----------

set_default_shell() {
  if [[ "$SHELL" == *"zsh"* ]]; then
    info "zsh is already the default shell"
    return
  fi

  local zsh_path
  zsh_path="$(which zsh)"

  # On Linux, zsh may not be installed yet
  if ! command -v zsh &>/dev/null; then
    if [[ "$OS" == "Linux" ]]; then
      info "Installing zsh..."
      if command -v apt-get &>/dev/null; then
        sudo apt-get update && sudo apt-get install -y zsh
      elif command -v dnf &>/dev/null; then
        sudo dnf install -y zsh
      elif command -v pacman &>/dev/null; then
        sudo pacman -S --noconfirm zsh
      else
        warn "Could not install zsh automatically. Please install it manually."
        return
      fi
      zsh_path="$(which zsh)"
    fi
  fi

  # Add to /etc/shells if missing
  if ! grep -qx "$zsh_path" /etc/shells; then
    info "Adding $zsh_path to /etc/shells..."
    echo "$zsh_path" | sudo tee -a /etc/shells >/dev/null
  fi

  info "Setting zsh as default shell..."
  chsh -s "$zsh_path"
}

# ---------- Linux prerequisites ----------

install_linux_prereqs() {
  if [[ "$OS" != "Linux" ]]; then
    return
  fi

  info "Installing Linux build prerequisites..."
  if command -v apt-get &>/dev/null; then
    sudo apt-get update
    sudo apt-get install -y build-essential procps curl file git
  elif command -v dnf &>/dev/null; then
    sudo dnf groupinstall -y 'Development Tools'
    sudo dnf install -y procps-ng curl file git
  elif command -v pacman &>/dev/null; then
    sudo pacman -S --noconfirm base-devel procps-ng curl file git
  fi
}

# ---------- Symlinks ----------

create_symlinks() {
  info "Creating config symlinks..."
  mkdir -p ~/.config
  make -C "$(cd "$(dirname "$0")" && pwd)" install
}

# ---------- Main ----------

main() {
  echo ""
  echo "========================================="
  echo "  Scaffolding Setup"
  echo "========================================="
  echo ""
  info "Detected: $OS ($ARCH)"
  echo ""

  if [[ "$OS" == "Linux" ]]; then
    install_linux_prereqs
  fi

  set_default_shell
  install_homebrew
  install_packages
  install_oh_my_zsh
  install_zsh_plugins
  create_symlinks

  echo ""
  info "Setup complete! Restart your shell or run: exec zsh"
  echo ""
}

main "$@"
