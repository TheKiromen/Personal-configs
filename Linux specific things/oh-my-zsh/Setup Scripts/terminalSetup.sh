#!/bin/bash

# Setup ZSH
echo "Setting up ZSH..."
sudo apt install -y zsh
# Make ZSH the default shell, restart needed for this to take effect
chsh -s $(which zsh)

# Install required packages
echo "Installing packages required for setup..."
sudo apt install -y git-all

# Install Oh My Zsh
echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

# Setup terminal based on configs in github
echo "Setting up .zshrc..."
git clone https://github.com/TheKiromen/Personal-configs.git
cp Personal-configs/Linux\ specific\ things/oh-my-zsh/.zshrc ~/
mkdir -p $ZSH/custom
cp Personal-configs/Linux\ specific\ things/oh-my-zsh/aliases.zsh $ZSH/custom/aliases.zsh
rm -rf Personal-configs

# Install supplementary packages
echo "Installing supplementary packages..."
DIVE_VERSION=$(curl -sL "https://api.github.com/repos/wagoodman/dive/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')
curl -fOL "https://github.com/wagoodman/dive/releases/download/v${DIVE_VERSION}/dive_${DIVE_VERSION}_linux_amd64.deb"
sudo apt install ./dive_${DIVE_VERSION}_linux_amd64.deb

# Prompt user to restart the computer
echo "ZSH setup complete. Please restart your computer for the changes to take effect."