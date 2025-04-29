#!/bin/bash

# Install packages
echo "Installing packages..."
apt install git-all

# Setup ZSH
echo "Setting up ZSH..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
chsh -s $(which zsh)

# Setup ZSH plugins
echo "Setting up ZSH plugins..."

# Setup .zshrc
echo "Setting up .zshrc..."