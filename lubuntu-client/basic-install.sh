#!/bin/bash

# Shortcut to path
git_url="https://raw.github.com/chrisfargen/rig/master"
rig_url="https://github.com/chrisfargen/rig.git"

# ADD REPOS

echo "** Adding repos..."
sudo add-apt-repository ppa:audacity-team/daily

# HOUSE CLEANING

echo "** Attempting to update system..."
sudo apt-get update ; sudo apt-get dist-upgrade -y

echo "** Attempting to install packages..."
sudo apt-get install vim git audacity sqlite3 sox libnotify-bin rdiff-backup -y

# PROJECT DIRECTORY STUFF

echo "** Creating document root..."
sudo mkdir -pv /var/www

echo "** Changing ownership on document root..."
sudo chown -Rv $USER:$USER /var/www

echo "** Adding sticky bit to document root..."
sudo chmod g+rwxs /var/www

# USER SETUP

# VIM STUFF

#echo "** Attempting to download minimal vim config..."
#wget -N $git_url/lib/.vimrc -P ~

cd /var/www
sudo git clone $rig_url


echo "export EDITOR=/usr/bin/vi" | sudo tee -a /home/$USER/.profile
echo "export VISUAL=/usr/bin/vi" | sudo tee -a /home/$USER/.profile

# GIT STUFF

echo "** Enabling password caching..."
# https://help.github.com/articles/set-up-git
git config --global credential.helper 'cache --timeout=3600'

# echo "** Attempting to download fargen site manager..."
# sudo wget $git_url/fargen-site.sh -O /usr/local/bin/fargen-site
# sudo wget -N $git_url/lib/fargen-vhost.conf -P /etc/nginx

# DROPBOX STUFF
# https://www.dropbox.com/install?os=lnx
cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -

~/.dropbox-dist/dropboxd

sudo wget https://www.dropbox.com/download?dl=packages/dropbox.py -O /usr/local/bin/dropbox.py

sudo chmod +x /usr/local/bin/dropbox.py

# OPENBOX STUFF

# Add to an openbox config file...
# ~/.dropbox-dist/dropboxd &
# ...
# 
# Also...
#
# - Disable scrolling to switch desktops
# - Add clock
# - Add network manager
# - Change desktop
# - Enable quick-start for chromium, terminator

wget -N $git_url/lubuntu-client/lib/rc.xml

# CHROMIUM PROCEDURE

# 1.  Install chromium-browser.
# 2.  Install lastpass extension.
# 3.  From chromium, sign in to lastpass.
# 4.  Sign in to chrome.

# ...

# SSH STUFF
mkdir ~/.ssh
# Make links to Dropbox keys
#cp -sfv ~/Dropbox/.ssh/*.pem ~/.ssh
cp -vfs $HOME/Dropbox/system/home/chrisfargen/.ssh/*.pem $HOME/.ssh


echo "** Hurray!"

exit 0
