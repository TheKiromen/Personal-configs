#!/bin/bash
#Install packages
choco install -y oh-my-posh
choco install -y terraform
choco install -y kubens kubectx

# Setup OMP
echo "Setting up OMP..."

# Setup OMP plugins
echo "Setting up OMP plugins..."

# Setup .bashrc and themes
echo "Setting up .bashrc..."