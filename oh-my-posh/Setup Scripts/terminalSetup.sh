#!/bin/bash

# Download windows terminal from Github releases
echo "Preinstalling necessary packages..."
# choco install microsoft-windows-terminal -Y # TODO: Verify if this works without ms store
# choco install jq -Y


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
echo "Creating profile for Git Bash..."
WT_CONFIG="$LOCALAPPDATA/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
CONFIG_UUID=$(powershell -Command "[guid]::NewGuid().ToString()")
# Check if file contains generated UUID
MAX_ATTEMPTS=100
ATTEMPT=0
while grep -q "$CONFIG_UUID" "$WT_CONFIG"; do
    CONFIG_UUID=$(powershell -Command "[guid]::NewGuid().ToString()")
    ATTEMPT=$((ATTEMPT + 1))
    if [ $ATTEMPT -ge $MAX_ATTEMPTS ]; then
        echo "Error: Could not generate a unique UUID after $MAX_ATTEMPTS attempts."
        exit 1
    fi
done
# Prepare the config block
CONFIG_BLOCK=$(cat <<EOF
{
    "colorScheme": "Dark+",
    "commandline": "%PROGRAMFILES%\\\\Git\\\\usr\\\\bin\\\\bash.exe -i -l",
    "font": {
        "face": "$FONT_FACE_NAME",
        "size": 10
    },
    "guid": "{$CONFIG_UUID}",
    "hidden": false,
    "icon": "C:\\\\Program Files\\\\Git\\\\mingw64\\\\share\\\\git\\\\git-for-windows.ico",
    "name": "Git Bash",
    "startingDirectory": "$HOME"
}
EOF
)

# Add new profile to the settings.json and set it as default
echo "Adding profile to settings.json..."
jq --argjson bashProfile "$CONFIG_BLOCK" '.profiles.list += [$bashProfile]' "$WT_CONFIG" > temp.json && mv temp.json settings.json
jq --arg newDefaultProfile "{$CONFIG_UUID}" '.defaultProfile = $newDefaultProfile' "$WT_CONFIG" > temp.json && mv temp.json settings.json

# Update git bash settings just in case
echo "Updating git bash settings..."
Set the font in git bash config in case it is used outside of windows terminal
if grep -q '^Font=' ~/.minttyrc; then
    sed -i '/^Font=/c\Font=JetBrainsMono NFM Medium' ~/.minttyrc
else
    echo 'Font=JetBrainsMono NFM Medium' >> ~/.minttyrc
fi

# Launch Windows Terminal to verify the changes
echo "Launching Windows Terminal..."
wt