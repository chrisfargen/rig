#!/bin/bash

echo $(date '+%s' -d '9am') | sudo tee /sys/class/rtc/rtc0/wakealarm
#sudo shutdown -h now

exit 0
