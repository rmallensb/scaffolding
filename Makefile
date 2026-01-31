# Dotfiles Management
# Run `make install` to symlink all configs
# Run `make uninstall` to remove symlinks

DOTFILES := $(PWD)/dotfiles

.PHONY: install uninstall nvim wezterm pgcli zsh

install: nvim wezterm pgcli zsh
	@echo "All dotfiles symlinked!"

uninstall:
	@echo "Removing symlinks..."
	rm -f ~/.config/nvim
	rm -f ~/.config/wezterm
	rm -f ~/.config/pgcli
	rm -f ~/.zshrc
	rm -f ~/.zprofile
	@echo "Symlinks removed. Original configs are still in this repo."

nvim:
	@echo "Linking nvim..."
	@if [ -e ~/.config/nvim ] && [ ! -L ~/.config/nvim ]; then \
		echo "Error: ~/.config/nvim exists and is not a symlink. Back it up first."; \
		exit 1; \
	fi
	rm -f ~/.config/nvim
	ln -s $(DOTFILES)/nvim ~/.config/nvim

wezterm:
	@echo "Linking wezterm..."
	@if [ -e ~/.config/wezterm ] && [ ! -L ~/.config/wezterm ]; then \
		echo "Error: ~/.config/wezterm exists and is not a symlink. Back it up first."; \
		exit 1; \
	fi
	rm -f ~/.config/wezterm
	ln -s $(DOTFILES)/wezterm ~/.config/wezterm

pgcli:
	@echo "Linking pgcli..."
	@if [ -e ~/.config/pgcli ] && [ ! -L ~/.config/pgcli ]; then \
		echo "Error: ~/.config/pgcli exists and is not a symlink. Back it up first."; \
		exit 1; \
	fi
	rm -f ~/.config/pgcli
	ln -s $(DOTFILES)/pgcli ~/.config/pgcli

zsh:
	@echo "Linking zsh..."
	@if [ -e ~/.zshrc ] && [ ! -L ~/.zshrc ]; then \
		echo "Error: ~/.zshrc exists and is not a symlink. Back it up first."; \
		exit 1; \
	fi
	@if [ -e ~/.zprofile ] && [ ! -L ~/.zprofile ]; then \
		echo "Error: ~/.zprofile exists and is not a symlink. Back it up first."; \
		exit 1; \
	fi
	rm -f ~/.zshrc ~/.zprofile
	ln -s $(DOTFILES)/zsh/.zshrc ~/.zshrc
	ln -s $(DOTFILES)/zsh/.zprofile ~/.zprofile
