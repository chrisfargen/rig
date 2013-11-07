#!/bin/bash

# Hostname
host_name="hostname.example1.com"

# Shortcut to path
git_url="https://raw.github.com/chrisfargen/rig/master/ubuntu-server"

# HOUSE CLEANING

echo "** Attempting to update system..."
sudo apt-get update && sudo apt-get upgrade -y

echo "** Attempting to install packages..."
sudo apt-get install vim git nginx -y

# USER SETUP

echo "Copying ssh key to '/etc/skel/'..."
sudo cp -r /home/ubuntu/.ssh /etc/skel

echo "** Input new user..."
read new_user

echo "** Creating new user '$new_user'..."
sudo adduser $new_user --gecos ""

echo "** Creating new group 'web'..."
sudo addgroup web

echo "** Adding user '$new_user' to group 'web'..."
sudo adduser $new_user web

echo "** Adding user '$new_user' to sudoers..."
echo "$new_user ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$new_user
sudo chmod -v 440 /etc/sudoers.d/$new_user

echo "** Changing host name to '$host_name'..."
sudo hostname $host_name
echo $host_name | sudo tee /etc/hostname
echo -e "127.0.1.1\t$host_name" | sudo tee -a /etc/hosts

# VIM STUFF

echo "** Attempting to download minimal vim config..."
wget -N $git_url/.vimrc

echo "export EDITOR=/usr/bin/vi" | sudo tee -a /home/$new_user/.profile
echo "export VISUAL=/usr/bin/vi" | sudo tee -a /home/$new_user/.profile

# WEB SERVER STUFF

echo "** Attempting to download fargen site manager..."
sudo wget $git_url/fargen-site.sh -O /usr/local/bin/fargen-site
sudo wget -N $git_url/lib/fargen-vhost.conf -P /etc/nginx
sudo wget -N $git_url/lib/basic-vhost -P /etc/nginx/sites-available
sudo wget -N $git_url/lib/robots.txt -P /usr/share/nginx/www

echo "** Creating nginx site config..."
sed "s/hostname.example2.com/$host_name/g" /etc/nginx/sites-available/basic-vhost | sudo tee /etc/nginx/sites-available/basic-vhost

echo "** Setting permissions on script..."
sudo chmod -v +x /usr/local/bin/fargen-site

echo "** Disable default enabled site..."
sudo rm -v /etc/nginx/sites-enabled/*

echo "** Making link to document root..."
sudo ln -sv /usr/share/nginx/www /var/www

echo "** Organize vhost skel..."
sudo mkdir -pv /usr/share/nginx/www/basic-vhost/htdocs
sudo cp /usr/share/nginx/www/index.html /usr/share/nginx/www/basic-vhost/htdocs
sudo cp /usr/share/nginx/www/robots.txt /usr/share/nginx/www/basic-vhost/htdocs

echo "** Changing ownership on document root..."
sudo chown -Rv :web /usr/share/nginx/www

echo "** Adding sticky bit to document root..."
sudo chmod g+rwxs /usr/share/nginx/www

echo "** Hurray!"

exit 0
