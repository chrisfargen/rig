#! /bin/bash

# http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-set-up.html

sudo apt-get install zip -y

wget https://s3.amazonaws.com/aws-cli/awscli-bundle.zip

unzip awscli-bundle.zip

sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

mkdir -p ~/.aws

#echo "** Copy file '.aws/config' from dropbox"

#echo "** Run 'aws ec2 describe-instances'"
