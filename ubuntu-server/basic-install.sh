#!/bin/bash

# Hostname
host_name="hostname.example1.com"
dr="/var/www"
rig_url="https://github.com/chrisfargen/rig.git"

# HOUSE CLEANING

# Allow for unattended mysql installation
echo "mysql-server-5.5 mysql-server/root_password password root" | sudo debconf-set-selections
echo "mysql-server-5.5 mysql-server/root_password_again password root" | sudo debconf-set-selections

echo "** Update system..."
sudo apt-get update ; sudo apt-get dist-upgrade -y

echo "** Install packages..."
sudo apt-get install vim git nginx mysql-server anacron php5-mysql curl zip -y

#echo "** Attempting to install autoupdate script..."

# USER SETUP

echo "** Copy ssh key to '/etc/skel/'..."
sudo cp -r $HOME/.ssh /etc/skel

echo "** Input new user..."
read new_user

echo "** Create new user '$new_user'..."
sudo adduser $new_user --gecos ""

echo "** Create new group 'web'..."
sudo addgroup web

echo "** Add user '$new_user' to group 'web'..."
sudo adduser $new_user web
sudo adduser ubuntu web

echo "** Add user '$new_user' to sudoers..."
echo "$new_user ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$new_user
sudo chmod -v 440 /etc/sudoers.d/$new_user

echo "** Change host name to '$host_name'..."
sudo hostname $host_name
echo $host_name | sudo tee /etc/hostname
echo -e "127.0.1.1\t$host_name" | sudo tee -a /etc/hosts

# TODO: COME BACK HERE 12/13

echo "** Make link to document root..."
sudo ln -s -v -T /usr/share/nginx/www $dr

echo "** Clone rig..."
cd /var/www/ ; sudo git clone $rig_url

# VIM STUFF

echo "** Attempt to download minimal vim config..."
sudo ln -s -v /var/www/rig/lib/.vimrc /home/$new_user/

# .profile
echo "export EDITOR=/usr/bin/vi" | sudo tee -a /home/$new_user/.profile
echo "export VISUAL=/usr/bin/vi" | sudo tee -a /home/$new_user/.profile

# .bashrc
echo "force_color_prompt=yes" | sudo tee -a /home/$new_user/.bashrc

# WEB SERVER STUFF

echo "** Attempt to symlink rig tools"
sudo ln -s -v -T $dr/rig/ubuntu-server/bin/fargen-site.sh /usr/local/bin/fargen-site
sudo ln -s -v -T $dr/rig/ubuntu-server/bin/unlock.sh /usr/local/bin/unlock
sudo ln -s -v $dr/rig/ubuntu-server/lib/fargen-vhost.conf /etc/nginx/
sudo ln -s -v $dr/rig/ubuntu-server/lib/basic-vhost /etc/nginx/sites-available/
sudo ln -s -v $dr/rig/ubuntu-server/lib/robots.txt /usr/share/nginx/

echo "** Create nginx site config..."
sudo sed "s/hostname.example2.com/$host_name/g" /etc/nginx/sites-available/basic-vhost | sudo tee /etc/nginx/sites-available/basic-vhost

sudo sed "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php5/fpm/php.ini | sudo dd of=/etc/php5/fpm/php.ini

sudo sed "s/listen = 127.0.0.1:9000/listen = \/var\/run\/php5-fpm.sock/g" /etc/php5/fpm/pool.d/www.conf | sudo dd of=/etc/php5/fpm/pool.d/www.conf

echo "** Set permissions on script..."
sudo chmod -v +x /usr/local/bin/fargen-site /usr/local/bin/unlock

echo "** Disable default enabled site..."
sudo rm -v /etc/nginx/sites-enabled/*

echo "** Set up 'rig' directory for latest scripts..."
cd $dr && sudo git clone https://github.com/chrisfargen/rig.git

echo "** Organize vhost skel..."
sudo mkdir -p -v $dr/basic-vhost/htdocs/
sudo cp -v $dr/index.html $dr/basic-vhost/htdocs/
sudo cp -v $dr/robots.txt $dr/basic-vhost/htdocs/

echo "** Change ownership on document root..."
sudo chown -R -v :web $dr/

echo "** Change permissions on document root..."
# find $dr -type f -exec chmod ug=rw,o=r {} \;
# find $dr -type d -exec chmod ug=rws,o=rx {} \;
sudo find $dr \
\( -type f -exec chmod 0664 {} \; \) , \
\( -type d -exec chmod 2775 {} \; \)

cd $dr && /usr/local/bin/unlock $dr

echo "** Random stuff..."

(for i in $(seq 1 12);
do
    echo "$(openssl rand -base64 12)"
done;
read -p "** Press any key to continue...")

echo "** Continue MySQL install ..."
sudo mysql_install_db

sudo mysql_secure_installation

sudo service php5-fpm reload

echo "** Would you like to enable nginx? [Y/n]"
read enable_nginx

if [ "$enable_nginx" = "y" ]
then
    sudo service nginx start
else
    echo "** Service nginx not enabled."
fi

echo "** Would you like to put the finishing touches on it (testing)? [Y/n]"
read enable_test_site

if [ "$enable_test_site" = "y" ]
then
    sudo service nginx start
    fargen-site add bourbon
    echo "<?php phpinfo() ?>" | sudo tee /var/www/bourbon/htdocs/index.php

else
    echo "** Test site not enabled."
fi

echo <<-EOM
** Info:
Host $1
HostName $(curl http://169.254.169.254/latest/meta-data/public-hostname)
User $new_user
# Fix below
#IdentityFile /home/$new_user/.ssh/$2.pem
EOM

echo "** Hurray!"

exit 0
