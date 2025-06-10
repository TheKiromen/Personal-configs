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
# Install the font
TEMP_DIR=$(mktemp -d)
curl -fLo "$TEMP_DIR/JetBrainsMono.zip" "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip"
unzip "$TEMP_DIR/JetBrainsMono.zip" -d "$TEMP_DIR"
mkdir -p ~/.local/share/fonts
mv "$TEMP_DIR/JetBrainsMonoNerdFont-Regular.ttf" ~/.local/share/fonts
fc-cache -fv
rm -rf "$TEMP_DIR"
gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrainsMono Nerd Font 10'

# Setup Powerlevel10k
echo "Setting up Powerlevel10k..."
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

# Setup terminal based on configs in github
echo "Setting up .zshrc..."
git clone https://github.com/TheKiromen/Personal-configs.git
cp Personal-configs/Linux\ specific\ things/oh-my-zsh/.zshrc ~/
cp Personal-configs/Linux\ specific\ things/oh-my-zsh/.p10k.zsh ~/
mkdir -p $ZSH/custom
cp Personal-configs/Linux\ specific\ things/oh-my-zsh/.aliases.zsh $HOME/.aliases.zsh
rm -rf Personal-configs

# Install supplementary packages
echo "Installing supplementary packages..."
# Dotnet
sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-9.0
sudo apt-get update && \
  sudo apt-get install -y aspnetcore-runtime-9.0
# Docker
sudo apt-get install -y docker.io
sudo systemctl enable docker
# Dive
DIVE_VERSION=$(curl -sL "https://api.github.com/repos/wagoodman/dive/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')
curl -fOL "https://github.com/wagoodman/dive/releases/download/v${DIVE_VERSION}/dive_${DIVE_VERSION}_linux_amd64.deb"
sudo apt install ./dive_${DIVE_VERSION}_linux_amd64.deb
# Fzf
sudo apt install -y fzf
# Lsd
sudo apt install -y lsd
# Clipboard history
sudo apt install -y copyq
copyq &
sleep 5  # wait for CopyQ to start and create config files
copyq config autostart true


# Prompt user to restart the computer
echo "ZSH setup complete. Please restart your computer for the changes to take effect."