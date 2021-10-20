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

echo "==> Copying artifacts to image"
# Copy artifacts
mkdir ~/Documents
mkdir ~/Documents/server
mv /tmp/webapp.zip ~/Documents/server
sudo apt-get install unzip
cd ~/Documents/server/ && unzip webapp.zip
cd ~/Documents/server/webapp-main && npm install

echo "==> Installing and configuring SQL"
# Install mysql
sudo apt-get install mysql-community-client-plugins mysql-common
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server

sudo mysql --user="root" --password="" --execute='CREATE USER '\''phpmyadmin'\''@'\''localhost'\'' IDENTIFIED BY "root";'
sudo mysql --user="root" --password="" --execute='ALTER USER '\''phpmyadmin'\''@'\''localhost'\'' IDENTIFIED WITH mysql_native_password BY "root";'
sudo mysql --user="root" --password="" --execute='CREATE DATABASE csye6225;'
sudo mysql --user="root" --password="" --execute='GRANT ALL PRIVILEGES ON csye6225.* TO '\''phpmyadmin'\''@'\''localhost'\'' ;'
sudo mysql --user="root" --password="" --execute='flush privileges;'
sudo mysql --user="phpmyadmin" --password="root" --database='csye6225' --execute="CREATE TABLE user (
  id int NOT NULL,
  first_name varchar(100) NOT NULL,
  last_name varchar(100) NOT NULL,
  username varchar(100) NOT NULL,
  password varchar(100) NOT NULL,
  account_created datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  account_updated datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
ALTER TABLE user
  ADD PRIMARY KEY (id,username);
ALTER TABLE user
  MODIFY id int NOT NULL AUTO_INCREMENT;"
  echo "==> Completed Provisioning!"