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

echo "==> Installing codedeploy."
# Install CodeDeploy
sudo apt-get install -y ruby
wget https://aws-codedeploy-us-east-1.s3.amazonaws.com/releases/codedeploy-agent_1.0-1.1597_all.deb
mkdir codedeploy-agent_1.0-1.1597_ubuntu20
dpkg-deb -R codedeploy-agent_1.0-1.1597_all.deb codedeploy-agent_1.0-1.1597_ubuntu20
sed 's/2.0/2.7/' -i ./codedeploy-agent_1.0-1.1597_ubuntu20/DEBIAN/control
dpkg-deb -b codedeploy-agent_1.0-1.1597_ubuntu20
dpkg -i codedeploy-agent_1.0-1.1597_ubuntu20.deb
systemctl start codedeploy-agent
systemctl enable codedeploy-agent

echo "==> Completed Provisioning!."