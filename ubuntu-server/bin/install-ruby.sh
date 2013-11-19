#!/bin/bash

# echo "** Installing curl..."
sudo apt-get install curl

# echo "** Installing RVM..."
curl -L https://get.rvm.io | bash -s stable

# echo "** Checking for RVM requirements..."
rvm requirements

# echo "** Installing Ruby..."
rvm install ruby

# echo "** Setting default Ruby version..."
rvm use ruby --default

# echo "** Installing RubyGems..."
rvm rubygems current

# echo "** Installing Rails..."
rvm install rails

echo "** Hurray!"

exit 0
