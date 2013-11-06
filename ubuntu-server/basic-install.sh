#!/bin/bash

# http://stackoverflow.com/a/192337/1351736
me="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
# Shortcut to path
git_url="https://raw.github.com/chrisfargen/rig/master/ubuntu-server"

echo "** Attempting to log..."
echo -e "$(date +'%F %R')\t$me\tJust checkin in!" >> log

# USER SETUP

echo "Copying ssh key to '/etc/skel/'..."
cp -r /home/ubuntu/.ssh /etc/skel

echo "** Input new user..."
read new_user

echo "** Creating new user '$new_user'..."
adduser $new_user

echo "** Creating new group 'web'..."
addgroup web

echo "** Adding user '$new_user' to group 'web'..."
adduser $new_user web

echo "** Adding user '$new_user' to sudoers..."
echo "$new_user ALL=(ALL) NOPASSWD:ALL" | tee /etc/sudoers.d/$new_user
chmod -v 440 /etc/sudoers.d/$new_user

echo "** Changing host name to '$1'..."
hostname $1
echo $1 | tee /etc/hostname
echo -e "127.0.1.1\t$1" | tee -a /etc/hosts

# User preferences
echo "export EDITOR=/usr/bin/vi" | tee -a /home/$new_user/.profile
echo "export VISUAL=/usr/bin/vi" | tee -a /home/$new_user/.profile


# HOUSE CLEANING

echo "** Attempting to update system..."
apt-get update && apt-get upgrade -y

echo "** Attempting to install packages..."
apt-get install vim git nginx mysql-server -y

# VIM STUFF

echo "** Attempting to download minimal vim config..."
wget -N $git_url/.vimrc

# WEB SERVER STUFF

echo "** Attempting to download fargen site manager..."
wget $git_url/fargen-site.sh -O /usr/local/bin/fargen-site
wget -N $git_url/fargen-vhost.conf -P /etc/nginx
wget -N $git_url/basic-vhost -P /etc/nginx/sites-available

echo "** Setting permissions on script..."
chmod -v +x usr/local/bin/fargen-site

echo "** Disable default enabled site..."
rm /etc/nginx/sites-enabled/*

echo "** Changing ownership on document root..."
chown -Rv :web /usr/share/nginx/www

echo "** Making link to document root..."
ln -sv /usr/share/nginx/www /var/www

echo "** Hurray!"

exit 0
