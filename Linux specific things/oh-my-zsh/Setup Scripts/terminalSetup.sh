#!/bin/bash

# Setup ZSH
echo "Setting up ZSH..."
sudo apt install -y zsh
# Make ZSH the default shell, restart needed for this to take effect
chsh -s $(which zsh)

# Setup .zshrc and themes
echo "Setting up .zshrc..."

# Setup ZSH plugins
echo "Setting up ZSH plugins..."

# Install packages
echo "Installing packages..."
DIVE_VERSION=$(curl -sL "https://api.github.com/repos/wagoodman/dive/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')
curl -fOL "https://github.com/wagoodman/dive/releases/download/v${DIVE_VERSION}/dive_${DIVE_VERSION}_linux_amd64.deb"
sudo apt install ./dive_${DIVE_VERSION}_linux_amd64.deb
sudo apt install git-all

# Prompt user to restart the computer
echo "ZSH setup complete. Please restart your computer for the changes to take effect."