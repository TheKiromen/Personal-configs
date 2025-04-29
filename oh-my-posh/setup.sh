#!/bin/bash

#Initialize the script
cd $HOME


#Install packages
choco install -y terraform
choco install -y kubens kubectx

# Setup OMP
echo "Setting up OMP..."
choco install -y oh-my-posh
# Pull the font from the repo
echo "Installing JetBrains Mono font..."
FONT_DIR="$HOME/fonts/JetBrainsMono"
mkdir -p $FONT_DIR
cd $FONT_DIR
curl -L -o "JetBrainsMono.zip" "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip"
unzip JetBrainsMono.zip
rm JetBrainsMono.zip
# Install the font into windows
FONT_FILE="JetBrainsMonoNerdFont-Medium.ttf"
cp "$FONT_DIR/$FONT_FILE" "/c/Windows/Fonts/"
# Register the font with the system
REG_FONT_NAME="JetBrainsMono TEST"
REG_FONT_FILE="JetBrainsMonoNerdFont-Medium.ttf"
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /v "$REG_FONT_NAME (TrueType)" /t REG_SZ /d "$REG_FONT_FILE" /f
fc-cache -f -v # Refresh cache just in case
cd $HOME

# Set the font in terminal config
if grep -q '^Font=' ~/.minttyrc; then
    sed -i '/^Font=/c\Font=JetBrainsMono NFM Medium' ~/.minttyrc
else
    echo 'Font=JetBrainsMono NFM Medium' >> ~/.minttyrc
fi

# Setup .bashrc and themes
echo "Setting up .bashrc..."

# Setup OMP plugins
echo "Setting up OMP plugins..."