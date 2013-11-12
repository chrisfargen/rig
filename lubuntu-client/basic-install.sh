#!/bin/bash

# Shortcut to path
git_url="https://raw.github.com/chrisfargen/rig/master"

# HOUSE CLEANING

echo "** Attempting to update system..."
sudo apt-get update && sudo apt-get upgrade -y

echo "** Attempting to install packages..."
sudo apt-get install vim git -y

# USER SETUP

# VIM STUFF

echo "** Attempting to download minimal vim config..."
wget -N $git_url/lib/.vimrc

echo "export EDITOR=/usr/bin/vi" | sudo tee -a /home/$USER/.profile
echo "export VISUAL=/usr/bin/vi" | sudo tee -a /home/$USER/.profile

# GIT STUFF

echo "** Enabling password caching..."
git config --global credential.helper 'cache --timeout=3600'

# echo "** Attempting to download fargen site manager..."
# sudo wget $git_url/fargen-site.sh -O /usr/local/bin/fargen-site
# sudo wget -N $git_url/lib/fargen-vhost.conf -P /etc/nginx

# PROJECT DIRECTORY STUFF

echo "** Creating document root..."
sudo mkdir -pv /var/www

echo "** Changing ownership on document root..."
sudo chown -Rv $USER:$USER /var/www

echo "** Adding sticky bit to document root..."
sudo chmod g+rwxs /var/www

echo "** Hurray!"

exit 0
