#!/bin/bash

#Initialize the script
cd $HOME

#Install packages
choco install -Y terraform
choco install -Y kubens kubectx

# Setup OMP
echo "Setting up OMP..."
choco install -Y oh-my-posh

# Setup .bashrc and themes
echo "Setting up .bashrc..."

# Setup OMP plugins
echo "Setting up OMP plugins..."