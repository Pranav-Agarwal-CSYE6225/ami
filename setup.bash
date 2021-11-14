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
sudo dpkg-deb -b codedeploy-agent_1.0-1.1597_ubuntu20
sudo dpkg -i codedeploy-agent_1.0-1.1597_ubuntu20.deb
sudo service codedeploy-agent start
sudo systemctl enable codedeploy-agent
echo "==> Installing cloudwatch."
wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
sudo dpkg -i -E ./amazon-cloudwatch-agent.deb
echo "==> Completed Provisioning!."