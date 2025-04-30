#!/bin/bash

# Download windows terminal from Github releases
echo "Installing Windows Terminal..."
choco install microsoft-windows-terminal # TODO: Verify if this works without ms store
# Create profile for Git Bash
WT_CONFIG="$LOCALAPPDATA/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
####################################### CURRENT CONFIG BLOCK #######################################
# {
#     "colorScheme": "Dark+",
#     "commandline": "%PROGRAMFILES%\\Git\\usr\\bin\\bash.exe -i -l",
#     "font": 
#     {
#         "face": "JetBrainsMono Nerd Font Mono",
#         "size": 10
#     },
#     "guid": "{9357d5bc-8563-41c7-aae7-f05534d6c9f3}",  <--- Verify if this can be generated through script, or Terminal has to do it
#     "hidden": false,
#     "icon": "C:\\Program Files\\Git\\mingw64\\share\\git\\git-for-windows.ico",
#     "name": "Git Bash",
#     "startingDirectory": "E:\\Projekty"
# }

# TODO: Download the fonts into temp folder in CWD
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
# powershell -ExecutionPolicy Bypass -File .\\font.ps1
cd $HOME

# Set the font in git bash config
if grep -q '^Font=' ~/.minttyrc; then
    sed -i '/^Font=/c\Font=JetBrainsMono NFM Medium' ~/.minttyrc
else
    echo 'Font=JetBrainsMono NFM Medium' >> ~/.minttyrc
fi

# Set the font in Windows Terminal config
# TODO: Grep for bash profile section and replace font.face param