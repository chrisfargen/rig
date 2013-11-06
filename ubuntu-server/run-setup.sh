#!/bin/bash

# http://stackoverflow.com/a/192337/1351736
me="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
#
git_url="https://raw.github.com/chrisfargen/rig/master/ubuntu-server"

echo "** Attempting to download script..."
wget -N $git_url/basic-install.sh -P ~/bin

echo "** Setting script permissions..."
chmod -v +x ~/bin/basic-install.sh

#echo "** Attempting to execute script..."
#bash ~/bin/basic-install.sh

echo "** Attempting to log..."
echo -e "$(date +'%F %R')\t$me\tJust checkin in!" >> log

echo "** Now try running: sudo bash ~/basic-install.sh [hostname]"
exit 0
