#!/bin/bash


# Setup ZSH
echo "Setting up ZSH..."
sudo apt install zsh

# Setup ZSH plugins
echo "Setting up ZSH plugins..."

# Setup .zshrc and themes
echo "Setting up .zshrc..."

# Install packages
echo "Installing packages..."
DIVE_VERSION=$(curl -sL "https://api.github.com/repos/wagoodman/dive/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')
curl -fOL "https://github.com/wagoodman/dive/releases/download/v${DIVE_VERSION}/dive_${DIVE_VERSION}_linux_amd64.deb"
sudo apt install ./dive_${DIVE_VERSION}_linux_amd64.deb
sudo apt install git-all