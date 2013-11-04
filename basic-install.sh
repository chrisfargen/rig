#!/bin/bash

# http://stackoverflow.com/a/192337/1351736
me="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
# Shortcut to path
git_url="https://raw.github.com/chrisfargen/rig/master"

echo "** Attempting to log..."
echo -e "$(date +'%F %R')\t$me\tJust checkin in!" >> log

# SYSTEM STUFF

#echo "** Creating new user..."

#echo "** Changing host name..."

echo "** Attempting to update system..."
apt-get update && apt-get upgrade -y

echo "** Attempting to install packages..."
apt-get install vim git nginx -y

# VIM STUFF

echo "** Attempting to download minimal vim config..."
wget -N $git_url/.vimrc

# WEB SERVER STUFF

echo "** Attempting to download fargen site manager..."
wget $git_url/fargen-site.sh -O /usr/local/bin/fargen-site
wget -N $git_url/fargen-vhost.conf -P /etc/nginx
wget -N $git_url/basic-vhost -P /etc/nginx/sites-available

echo "** Setting permissions on script..."
chmod -v +x ~/bin/fargen-site.sh

echo "** Disable default enabled site..."
rm /etc/nginx/sites-enabled/*

echo "** Changing ownership on document root..."
chown -Rv ubuntu:ubuntu /usr/share/nginx/www

echo "** Making link to document root..."
ln -sv /usr/share/nginx/www /var/www

echo "** Enabling start nginx on boot..."
chkconfig nginx on

echo "** Hurray!"

exit 0
