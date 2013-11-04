#!/bin/bash

# $1 is ssh host (i.e., user@host)

#
exit_code=1
# Time to wait between attempts
wait_time="10s"
# http://stackoverflow.com/a/192337/1351736
me="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"

while [ " $exit_code" -ne "0" ]; do
    echo "** Testing for SSH connection..."
    ssh -o ConnectTimeout=10 -o StrictHostKeyChecking=no $1 <<EOM
        echo -e "$(date +'%F %R')\t$me\tEstablished a sweet connection!" >> log
EOM
    exit_code=$?
    if [ "$exit_code" -ne "0" ]
    then
        echo "** SSH exit code is $exit_code. Trying again in $wait_time..."
        sleep $wait_time
    fi  
done
echo "** Success!"

exit 0
