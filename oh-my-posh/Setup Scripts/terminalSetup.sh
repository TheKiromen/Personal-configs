#!/bin/bash

# Download windows terminal from Github releases
echo "Installing Windows Terminal..."
# choco install microsoft-windows-terminal # TODO: Verify if this works without ms store


# Pull the font from the repo
echo "Installing JetBrains Mono font..."
FONT_DIR="tmp"
FONT_FILE="JetBrainsMonoNerdFont-Medium.ttf"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip"

mkdir -p $FONT_DIR
cd $FONT_DIR
curl -L -o "JetBrainsMono.zip" $FONT_URL
unzip JetBrainsMono.zip
rm JetBrainsMono.zip
# Install the font into windows
FONT_PATH_WINDOWS=$(cygpath -w "$(pwd)/$FONT_FILE")
echo $FONT_PATH_WINDOWS
FONT_FACE_NAME=$(powershell -ExecutionPolicy Bypass -File .\\..\\installFont.ps1 -fontPath "$FONT_PATH_WINDOWS")
cd ".."
rm tmp -r

# Create profile for Git Bash
WT_CONFIG="$LOCALAPPDATA/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
CONFIG_UUID=$(uuidgen)
# Check if file contains generated UUID
MAX_ATTEMPTS=100
ATTEMPT=0
while grep -q "$CONFIG_UUID" "$WT_CONFIG"; do
    CONFIG_UUID=$(uuidgen)
    ATTEMPT=$((ATTEMPT + 1))
    if [ $ATTEMPT -ge $MAX_ATTEMPTS ]; then
        echo "Error: Could not generate a unique UUID after $MAX_ATTEMPTS attempts."
        exit 1
    fi
done
# Prepare the config block
# TODO: Verify if all is escaped correctly
# CONFIG_BLOCK=",{
#     "colorScheme": "Dark+",
#     "commandline": "%PROGRAMFILES%\\Git\\usr\\bin\\bash.exe -i -l",
#     "font": 
#     {
#         "face": "$FONT_FACE_NAME", 
#         "size": 10
#     },
#     "guid": "{$CONFIG_UUID}",
#     "hidden": false,
#     "icon": "C:\\Program Files\\Git\\mingw64\\share\\git\\git-for-windows.ico",
#     "name": "Git Bash",
#     "startingDirectory": "$HOME"
# }"

# Add new profile to the settings.json and set it as default

# Set the font in git bash config in case it is used outside of windows terminal
# if grep -q '^Font=' ~/.minttyrc; then
#     sed -i '/^Font=/c\Font=JetBrainsMono NFM Medium' ~/.minttyrc
# else
#     echo 'Font=JetBrainsMono NFM Medium' >> ~/.minttyrc
# fi
