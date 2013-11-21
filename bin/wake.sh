#! /bin/bash

echo $(date '+%s' -d '9am') | sudo tee /sys/class/rtc/rtc0/wakealarm
#sudo shutdown -h now

#play -q /var/www/fargen-pom/bell.wav vol 0.25

exit 0
