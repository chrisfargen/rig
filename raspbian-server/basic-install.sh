#!/bin/bash

# Shortcut to path
git_url="https://raw.github.com/chrisfargen/rig/master"

# HOUSE CLEANING

echo "** Attempting to update system..."
sudo apt-get update && sudo apt-get dist-upgrade -y

echo "** Attempting to install packages..."
sudo apt-get install vim -y

# USER SETUP

# VIM STUFF

echo "** Attempting to download minimal vim config..."
wget -N $git_url/lib/.vimrc -P ~

echo "export EDITOR=/usr/bin/vi" | sudo tee -a $HOME/.profile
echo "export VISUAL=/usr/bin/vi" | sudo tee -a $HOME/.profile

# DROPBOX STUFF
# https://www.dropbox.com/install?os=lnx
cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -

~/.dropbox-dist/dropboxd

sudo wget https://www.dropbox.com/download?dl=packages/dropbox.py -O /usr/local/bin/dropbox.py

sudo chmod +x /usr/local/bin/dropbox.py

# SSH STUFF
mkdir ~/.ssh
# Make links to Dropbox keys
cp -sfv ~/Dropbox/.ssh/*.pem ~/.ssh

# AWS STUFF

# ...

# GIT STUFF

# Set up private repo

# ...

# RTORRENT STUFF 

# ...

# GOOGLE STUFF
# https://code.google.com/p/googlecl/wiki/Install

# ...

# ELINKS STUFF

# ...

echo "** Hurray!"

exit 0
