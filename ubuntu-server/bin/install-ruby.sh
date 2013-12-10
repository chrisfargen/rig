#!/bin/bash

# http://ruby.railstutorial.org/ruby-on-rails-tutorial-book

echo "** Install RVM..."
curl -L https://get.rvm.io | bash -s

echo "** Review requirements..."
rvm requirements

echo "** Install Ruby..."
rvm install 2.0.0

echo "** Create gemset..."
rvm use 2.0.0@railstutorial_rails_4_0 --create --default

echo "** Check RubyGems installation..."
which gem

echo "** Set RubyGems version..."
gem update --system 2.1.9

# Create a gem configuration file '~/.gemrc' to prevent automatic documentation generation
#   install: --no-rdoc --no-ri
#   update:  --no-rdoc --no-ri

echo "** Install Rails..."
gem install rails --version 4.0.2

echo "** Installing additional Linux-only packages..."
sudo apt-get install libxslt-dev libxml2-dev libsqlite3-dev

exit 0

# # https://www.digitalocean.com/community/articles/how-to-install-ruby-on-rails-on-ubuntu-12-04-lts-precise-pangolin-with-rvm
# 
# echo "** Installing known deps..."
# sudo apt-get install curl nodejs
# 
# echo "** Installing RVM..."
# curl -L https://get.rvm.io | bash -s stable
# 
# echo "** Sourcing RVM..."
# . ~/.rvm/scripts/rvm
# 
# echo "** Checking for RVM requirements..."
# rvm requirements
# 
# echo "** Installing Ruby..."
# rvm install ruby
# 
# echo "** Setting default Ruby version..."
# rvm use ruby --default
# 
# echo "** Installing RubyGems..."
# rvm rubygems current
# 
# echo "** Installing Rails..."
# gem install rails
# 
# echo "** Installing Bundler..."
# gem install bundler

echo "** Hurray!"

exit 0
