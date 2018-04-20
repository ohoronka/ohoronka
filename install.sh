#!/usr/bin/env bash
## Install user
sudo adduser bguban
sudo usermod -aG adm,dialout,cdrom,floppy,sudo,audio,dip,video,plugdev,netdev,lxd bguban
sudo cp -r .ssh/ /home/bguban
sudo chown -R bguban.bguban /home/bguban/.ssh

sudo curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
sudo echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -

sudo apt-get update

sudo apt-get -y install mc nodejs redis-server nginx monit libpq-dev yarn libmosquitto-dev nodejs

# local user
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io | bash -s stable

#sudo update-rc.d monit defaults
#sudo update-rc.d monit enable
#sudo /etc/init.d/monit start

sudo mkdir /var/projects
sudo chown -R bguban.bguban /var/projects
source /home/bguban/.rvm/scripts/rvm
rvm install 2.4.0
rvm use 2.4.0
rvm gemset create ohoronka
rvm use 2.4.0@ohoronka
gem install bundler
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo echo "bguban ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers



#############################
sudo curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
sudo echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
sudo echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" >> /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

sudo apt-get update

sudo apt-get -y install mc nodejs redis-server nginx monit libpq-dev yarn libmosquitto-dev nodejs libmagickwand-dev postgresql

# local user
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io | bash -s stable

source /home/bguban/.rvm/scripts/rvm
rvm install 2.4.0
rvm use 2.4.0
rvm gemset create ohoronka
rvm use 2.4.0@ohoronka
gem install bundler

cap staging deploy:check
scp -r config/deploy/config 192.168.7.120:/var/projects/ohoronka/shared
cap staging deploy:check
cap staging puma:nginx_config
