#!/bin/bash

sudo echo $(date '+%s' -d '10am') | sudo tee /sys/class/rtc/rtc0/wakealarm
sudo echo $(date '+%s' -d '5pm') | sudo tee /sys/class/rtc/rtc0/wakealarm
#sudo shutdown -h now
