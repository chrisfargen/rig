#!/bin/bash

echo "Ready to shut down? [Y/n]"

read shutdown

if [ "$shutdown" = "y" ]
then
    echo "** Shutting down..."
    #/usr/bin/chromium-browser --new-window images.google.com
    sudo shutdown -h now
elif [ "$shutdown" = "n" ]
then
    echo "** Delaying shutdown..."
else
    echo "** Not understood. Exiting..."
    sleep 1
    exit 1
fi

sleep 1

exit 0
