#!/bin/bash

#Initialize the script
cd $HOME

#Install packages
choco install -y terraform
choco install -y kubens kubectx

# Setup OMP
echo "Setting up OMP..."
choco install -y oh-my-posh

# Setup .bashrc and themes
echo "Setting up .bashrc..."

# Setup OMP plugins
echo "Setting up OMP plugins..."