#!/usr/bin/env bash
## Install user
sudo adduser bguban
sudo usermod -aG adm,dialout,cdrom,floppy,sudo,audio,dip,video,plugdev,netdev,lxd bguban
sudo cp -r .ssh/ /home/bguban
sudo chown -R bguban.bguban /home/bguban/.ssh
sudo apt-get update

## install environment
sudo apt-get -y install mc nodejs redis-server nginx monit
sudo update-rc.d monit defaults
sudo update-rc.d monit enable
sudo /etc/init.d/monit start

sudo mkdir /var/projects
sudo chown -R bguban.bguban /var/projects
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io | bash -s stable
source /home/bguban/.rvm/scripts/rvm
rvm install 2.4.0
rvm use 2.4.0
rvm gemset create ohoronka
rvm use 2.4.0@ohoronka
gem install bundler
sudo apt-get install libpq-dev
sudo apt-get install nginx
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn
sudo echo "bguban ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
apt-get install libmosquitto-dev
