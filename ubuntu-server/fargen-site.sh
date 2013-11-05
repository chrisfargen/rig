#!/bin/bash

echo "** Fargen Site (nginx site manager) initiated!"

if [ "$1" = "add" ]
then
    echo "** Attempting to add site..."
    # TODO: Validate name using grep and regular expressions
    if [ ! -z "$2" ]
    #if [[ "$2" =~ "^[a-zA-Z0-9_]+$" ]]
    #if
    then
        echo "** Creating nginx site config..."
        sed "s/basic-vhost/$2/g" /etc/nginx/sites-available/basic-vhost > /etc/nginx/sites-available/$2
        echo "** Creating folder for document root..."
        mkdir -pv /usr/share/nginx/www/$2
        echo "** Adding some test text..."
        sed "s/nginx/$2/g" /usr/share/nginx/www/index.html > /usr/share/nginx/www/$2/index.html
        # Ask if user wants to enable site
        echo "** Would you like to enable this site? (y/n)"
        read fargen_enable
        if [ $fargen_enable = "y" ]
        then
            echo "** Attempting to enable..."
            ln -sv /etc/nginx/sites-available/$2 /etc/nginx/sites-enabled/$2
            service nginx reload
        else
            echo "** Site added but not enabled."
        fi
    else
        echo "** Add attempt failed. Check the site name."
    fi
elif [ "$1" = "rm" ]
then
    echo "** Attempting to remove..."
else
    echo "** What to do?"
fi

exit 0
