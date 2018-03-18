#!/usr/bin/env bash

. /lib/lsb/init-functions

log_begin_msg "Update package informations"
sudo apt-get update > /dev/null 2>&1
log_end_msg 0


log_begin_msg "Installing utilities"
sudo apt-get install -y htop > /dev/null 2>&1
log_success_msg "htop was installed"

sudo apt-get install -y git > /dev/null 2>&1
log_success_msg "git was installed"

sudo apt-get install -y vim > /dev/null 2>&1
log_success_msg "vim was installed"
log_end_msg 0

log_begin_msg "Installing openjdk-8-jre"
sudo add-apt-repository -y ppa:openjdk-r/ppa > /dev/null 2>&1
sudo apt-get update > /dev/null 2>&1
sudo sudo apt-get install -y openjdk-8-jre > /dev/null 2>&1
wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -   > /dev/null 2>&1
log_end_msg 0

log_begin_msg "Installing composer"
sudo curl -sS https://getcomposer.org/installer | php > /dev/null 2>&1
sudo mv composer.phar /usr/local/bin/composer > /dev/null 2>&1
if [ ! -d "/root/.composer" ]; then
  sudo mkdir /root/.composer > /dev/null
fi
sudo cp /vagrant/composer/auth.json /root/.composer/auth.json > /dev/null 2>&1
sudo cp -R /vagrant/etc / > /dev/null 2>&1
log_end_msg 0

log_begin_msg "Install NodeJS"
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs > /dev/null 2>&1
log_success_msg "node was installed"

sudo apt-get install -y build-essential > /dev/null 2>&1
log_success_msg "build tools was installed"

log_end_msg 0

log_begin_msg "Install Solidity tools"

sudo npm install -g truffle > /dev/null 2>&1
log_success_msg "truffle was installed"

log_end_msg 0


log_success_msg "Project server has been installed"


