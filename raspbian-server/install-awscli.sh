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
#scp -i ~/.ssh/[PEM FILE FOR SCP] /home/chrisfargen/.ssh/[PEM FILE FOR SERVER TO BE] ubuntu@[PUBLIC DNS]:/home/ubuntu/.ssh

#chmod 400 ~/.ssh/*.pem

#/var/www/rig/raspbian-server/make-server.sh ec20.5746.in ~/.ssh/[PEM FILE FOR SERVER TO BE] 54.214.41.91
