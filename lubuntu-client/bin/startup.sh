#!/bin/bash

echo "** Ready to update?"

read update_now

if [ "$update_now" = "y" ]
then
    echo "** Updating via apt-get..."
    sudo apt-get update && sudo apt-get upgrade -y
    echo "** Updating via git repo..."
    cd /var/www/rig && git pull
else
    echo "** Delaying update..."
fi

echo "** Ready to backup?"

read backup_now

if [ "$backup_now" = "y" ]
then
    rdiff-backup --exclude-globbing-filelist /var/www/rig/lubuntu-client/lib/.rdiff-exclude /home/chrisfargen chrisfargen@raspi.5746.in::/var/backups/lubuntu-macbook
else
    echo "** Delaying backup..."
fi
