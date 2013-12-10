#! /bin/bash

# http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-set-up.html

# echo "** Start instance..."

# echo "** SSH into instance..."

cd ~

sudo apt-get update && sudo apt-get dist-upgrade -y

sudo apt-get install zip -y

wget https://s3.amazonaws.com/aws-cli/awscli-bundle.zip

unzip awscli-bundle.zip

sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

mkdir -p ~/.aws

#echo "** Copy file '.aws/config' from dropbox"

#touch ~/.aws/config

#echo "** Run 'aws ec2 describe-instances'"

echo "** AWS command line tools installed! Hurray!"

################################

sudo apt-get install git -y

sudo mkdir -p /var/www

sudo chown $USER:$USER /var/www

cd /var/www

git clone https://github.com/chrisfargen/rig.git

chmod +x /var/www/rig/raspbian-server/make-server.sh 

#Copy security key (.pem file) from dropbox to '~/.ssh/'
#scp -i ~/.ssh/key-2013-10-25.pem /home/chrisfargen/.ssh/key-2013-10-25.pem ubuntu@[PUBLIC DNS]:/home/ubuntu/.ssh

/var/www/rig/raspbian-server/make-server.sh ec20.5746.in ~/.ssh/key-2013-10-25.pem 54.214.41.91
