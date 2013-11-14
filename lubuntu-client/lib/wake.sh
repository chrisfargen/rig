#!/bin/bash

echo 0 | sudo tee /sys/class/rtc/rtc0/wakealarm
echo $(date +%s -d "8am today") | sudo tee /sys/class/rtc/rtc0/wakealarm
