#!/bin/bash

echo "==> Installing node version manager (NVM)."
# Install NVM
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.39.0/install.sh | bash
source ~/.bashrc
source ~/.nvm/nvm.sh
nvm install 14
npm install -g npm@latest

echo "==> Updating APT."
# Update APT
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install unzip

echo "==> Completed Provisioning!."