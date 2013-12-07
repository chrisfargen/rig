#! /bin/bash

# http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-set-up.html#install-with-pip

echo "** Installing pip..."
sudo apt-get install python-pip

echo "** Installing awscli..."
pip install awscli
