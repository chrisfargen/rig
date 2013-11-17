#!/bin/bash

# Hostname
host_name="hostname.example1.com"
dr="/var/www"

# Shortcut to path
git_url="https://raw.github.com/chrisfargen/rig/master"

# HOUSE CLEANING

echo "** Attempting to update system..."
sudo apt-get update && sudo apt-get upgrade -y

echo "** Attempting to install packages..."
sudo apt-get install vim git nginx mysql-server php5-mysql -y

# USER SETUP

echo "Copying ssh key to '/etc/skel/'..."
sudo cp -r $HOME/.ssh /etc/skel

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
wget -N $git_url/ubuntu-server/lib/.vimrc -P /home/$new_user

echo "export EDITOR=/usr/bin/vi" | sudo tee -a /home/$new_user/.profile
echo "export VISUAL=/usr/bin/vi" | sudo tee -a /home/$new_user/.profile

# WEB SERVER STUFF

echo "** Attempting to download fargen site manager..."
sudo wget $git_url/ubuntu-server/fargen-site.sh -O /usr/local/bin/fargen-site
sudo wget $git_url/bin/unlock.sh -O /usr/local/bin/unlock
sudo wget -N $git_url/ubuntu-server/lib/fargen-vhost.conf -P /etc/nginx
sudo wget -N $git_url/ubuntu-server/lib/basic-vhost -P /etc/nginx/sites-available
sudo wget -N $git_url/ubuntu-server/lib/robots.txt -P /usr/share/nginx/www

echo "** Creating nginx site config..."
sed "s/hostname.example2.com/$host_name/g" /etc/nginx/sites-available/basic-vhost | sudo tee /etc/nginx/sites-available/basic-vhost

sudo sed "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php5/fpm/php.ini | sudo dd of=/etc/php5/fpm/php.ini

sed "s/listen = 127.0.0.1:9000/listen = \/var\/run\/php5-fpm.sock/g" /etc/php5/fpm/pool.d/www.conf | sudo dd of=/etc/php5/fpm/pool.d/www.conf

echo "** Setting permissions on script..."
sudo chmod -v +x /usr/local/bin/fargen-site /usr/local/bin/unlock

echo "** Disable default enabled site..."
sudo rm -v /etc/nginx/sites-enabled/*

echo "** Making link to document root..."
sudo ln -svT /usr/share/nginx/www $dr

echo "** Organize vhost skel..."
sudo mkdir -pv $dr/basic-vhost/htdocs
sudo cp $dr/index.html $dr/basic-vhost/htdocs
sudo cp $dr/robots.txt $dr/basic-vhost/htdocs

echo "** Changing ownership on document root..."
sudo chown -Rv :web $dr/

echo "** Changing permissions on document root..."
# find $dr -type f -exec chmod ug=rw,o=r {} \;
# find $dr -type d -exec chmod ug=rws,o=rx {} \;
find $dr \
\( -type f -exec chmod 0664 {} \; \) , \
\( -type d -exec chmod 2775 {} \; \)

echo "** MySQL install continuing..."
sudo mysql_install_db

sudo mysql_secure_installation


echo "** Hurray!"

exit 0
