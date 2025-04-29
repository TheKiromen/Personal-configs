#!/bin/bash

#Install packages
choco install -y terraform
choco install -y kubens kubectx

# Setup OMP
echo "Setting up OMP..."
choco install -y oh-my-posh

echo "Installing JetBrains Mono font..."
FONT_DIR = "$HOME/.local/share/fonts/JetBrainsMono"
mkdir -p $FONT_DIR
cd $FONT_DIR
curl -L -o "JetBrainsMono.zip" "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip"
unzip JetBrainsMono.zip
rm JetBrainsMono.zip
fc-cache -f -v # Refresh cache just in case

# Setup .bashrc and themes
echo "Setting up .bashrc..."

# Setup OMP plugins
echo "Setting up OMP plugins..."