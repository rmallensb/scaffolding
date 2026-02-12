# scaffolding

Dotfiles and dev environment config. Works on macOS and Linux.

## Quick Start

```bash
git clone git@github.com:<you>/scaffolding.git ~/personal/scaffolding
cd ~/personal/scaffolding
make setup
```

`make setup` runs the full bootstrap: installs dependencies, sets zsh as default shell, and symlinks everything into place. Restart your shell (or `exec zsh`) when it's done.

## What Gets Installed

**Via Homebrew:**
neovim, tmux, ripgrep, fd, eza, zoxide, fzf, zsh-autosuggestions, zsh-syntax-highlighting, powerlevel10k

**Via install scripts:**
Oh My Zsh, zsh-vi-mode plugin

## What Gets Symlinked

| Source | Target |
|---|---|
| `dotfiles/nvim/` | `~/.config/nvim` |
| `dotfiles/wezterm/` | `~/.config/wezterm` |
| `dotfiles/pgcli/` | `~/.config/pgcli` |
| `dotfiles/tmux/` | `~/.config/tmux` |
| `dotfiles/zsh/.zshrc` | `~/.zshrc` |
| `dotfiles/zsh/.zprofile` | `~/.zprofile` |

## Make Targets

| Command | Description |
|---|---|
| `make setup` | Full bootstrap (deps + symlinks) |
| `make install` | Symlink all configs |
| `make uninstall` | Remove all symlinks |
| `make nvim` | Symlink nvim only |
| `make zsh` | Symlink zsh only |
| `make wezterm` | Symlink wezterm only |
| `make pgcli` | Symlink pgcli only |
| `make tmux` | Symlink tmux only |

## Structure

```
dotfiles/
  nvim/         # Neovim config (lazy.nvim, LSP, telescope, etc.)
  zsh/          # .zshrc + .zprofile (oh-my-zsh, p10k, vim mode)
  wezterm/      # WezTerm terminal config
  tmux/         # tmux config (Ctrl-Space prefix, vim nav)
  pgcli/        # PostgreSQL CLI config
scripts/
  load-secrets.sh
```

Symlinks are safe — `make install` won't overwrite existing non-symlink files. Back them up first if they exist.
