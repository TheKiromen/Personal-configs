#!/bin/bash

#Initialize the script
cd $HOME

# Setup OMP
echo "Setting up OMP..."
choco install -Y oh-my-posh

# Setup .bashrc and themes
echo "Setting up .bashrc..."
git clone https://github.com/TheKiromen/Personal-configs.git ~/temp-configs
cp -r ~/temp-configs/oh-my-posh/BashThemes ~/BashThemes
cp -f ~/temp-configs/oh-my-posh/.bashrc ~/.bashrc
cp -f ~/temp-configs/oh-my-posh/.bash_profile ~/.bash_profile
rm -rf ~/temp-configs

# Setup OMP plugins
echo "Setting up OMP plugins..."

# Refresh bash
exec bash

#Install packages
choco install -Y lsd
choco install -Y dive
choco install -Y python
choco install -Y terraform
choco install -Y kubens kubectx