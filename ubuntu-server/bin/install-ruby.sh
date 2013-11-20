#!/bin/bash

# https://www.digitalocean.com/community/articles/how-to-install-ruby-on-rails-on-ubuntu-12-04-lts-precise-pangolin-with-rvm

echo "** Installing known deps..."
sudo apt-get install curl nodejs

echo "** Installing RVM..."
curl -L https://get.rvm.io | bash -s stable

echo "** Sourcing RVM..."
. ~/.rvm/scripts/rvm

echo "** Checking for RVM requirements..."
rvm requirements

echo "** Installing Ruby..."
rvm install ruby

echo "** Setting default Ruby version..."
rvm use ruby --default

echo "** Installing RubyGems..."
rvm rubygems current

echo "** Installing Rails..."
gem install rails

echo "** Installing Bundler..."
gem install bundler

echo "** Hurray!"

exit 0
