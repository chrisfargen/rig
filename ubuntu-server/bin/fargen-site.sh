#!/bin/bash

#
# https://github.com/WordPress/WordPress/archive/master.zip
# https://github.com/h5bp/html5-boilerplate/archive/master.zip
#

echo "** Fargen Site (nginx site manager) initiated!"

if [ "$1" = "add" ]
then
    echo "** Add site..."
    # TODO: Validate name using grep and regular expressions
    if [ ! -z "$2" ]
    #if [[ "$2" =~ "^[a-zA-Z0-9_]+$" ]]
    #if
    then
        echo "** Create nginx site config..."
        sed "s/basic-vhost/$2/g" /etc/nginx/sites-available/basic-vhost | sudo tee /etc/nginx/sites-available/$2

        echo "** Create folder for document root..."
        #sudo mkdir -pv /usr/share/nginx/www/$2
	sudo cp -rpT /usr/share/nginx/www/basic-vhost /usr/share/nginx/www/$2

        echo "** Add some test text..."
        #sed "s/nginx/$2/g" /usr/share/nginx/www/index.html | sudo tee /usr/share/nginx/www/$2/index.html
	sudo sed -i "s/nginx/$2/g" /usr/share/nginx/www/$2/htdocs/index.html

        echo "** Would you like to enable this site? [Y/n]"
        read fargen_enable
        if [ $fargen_enable = "y" ]
        then
            echo "** Attempt to enable..."
            sudo ln -sv /etc/nginx/sites-available/$2 /etc/nginx/sites-enabled/$2
            sudo service nginx reload
        else
            echo "** Site added but not enabled."
        fi
    else
        echo "** Add attempt failed. Check the site name."
    fi
elif [ "$1" = "rm" ]
then
    echo "** Attempt to remove..."
else
    echo "** What to do?"
fi

exit 0
