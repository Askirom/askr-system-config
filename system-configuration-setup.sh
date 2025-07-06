#!/bin/bash

echo "Setting up dotfiles from Askr.System_Configuration..."

# Check if dotfiles directory exists
if [ ! -d "$HOME/dotfiles" ]; then
  echo "Cloning dotfiles repository..."
  git clone https://github.com/Askirom/Askr.System_Configuration.git ~/dotfiles
  cd ~/dotfiles
else
  echo "Dotfiles directory exists, pulling latest changes..."
  cd ~/dotfiles
  git pull
fi

echo "Creating backup directories..."
mkdir -p ~/.config/backups

echo "Creating symlinks..."

# Backup existing configs if they exist
[ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config/backups/nvim.backup.$(date +%Y%m%d_%H%M%S)
[ -f ~/.wezterm.lua ] && mv ~/.wezterm.lua ~/.config/backups/wezterm.lua.backup.$(date +%Y%m%d_%H%M%S)
[ -d ~/.config/zellij ] && mv ~/.config/zellij ~/.config/backups/zellij.backup.$(date +%Y%m%d_%H%M%S)

# Create symlinks
ln -sf ~/dotfiles/neovim ~/.config/nvim
ln -sf ~/dotfiles/wezterm/wezterm.lua ~/.wezterm.lua
ln -sf ~/dotfiles/zellij ~/.config/zellij

echo "Installing/updating Homebrew packages..."
if command -v brew >/dev/null 2>&1; then
  brew bundle --file=~/dotfiles/homebrew/Brewfile
else
  echo "Homebrew not installed. Install from https://brew.sh first."
fi

echo "Dotfiles setup complete!"
echo ""
echo "Remember to manually configure:"
echo "- GitHub SSH keys"
echo "- Git user.name and user.email (git config --global user.name 'Your Name')"
echo "- Any application-specific settings"
echo ""
echo "Backups stored in ~/.config/backups/"
