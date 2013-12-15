#!/bin/bash

# NOTE: This script only works when there
# is no instance with the given elastic IP

# $1 is intended host name
# $2 is path of key pair
# $3 is elastic ip address

# Time to wait for instance to initiate
instance_wait="90s"

# Path to key file
key_path=$HOME/.ssh/$2.pem

# http://stackoverflow.com/a/192337/1351736
me="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"

#
git_url="https://raw.github.com/chrisfargen/rig/master"

# Outputting variables
cat <<EOM
** Intended host name: $1
** Elastic IP address: $3
** Name of key pair: $2
** Path to key: $key_path
EOM

# aws

echo "** Attempting to run instance..."
last_instance_id=$(\
    aws ec2 run-instances \
    --image-id "ami-6aad335a" \
    --key-name $2 \
    --instance-type "t1.micro" \
    --query "Instances[0].InstanceId" \
    | sed -e 's/^"//'  -e 's/"$//')

echo "** Instance id: $last_instance_id"

echo "** Attempting to create name tag $1..."
aws ec2 create-tags --resources $last_instance_id --tags Key=Name,Value=$1 --output text

#echo "** Attempting to terminate instance $last_instance_id..."
#aws ec2 terminate-instances --instance-ids $last_instance_id --output text

echo "** Clearing host fingerprint for address $3..."
ssh-keygen -f ~/.ssh/known_hosts -R $3

echo "** Clearing host fingerprint for address $1..."
ssh-keygen -f ~/.ssh/known_hosts -R $1

echo "** Sleeping $instance_wait while instance initiates..."
sleep $instance_wait

echo "** Attempting to associate address $3..."
aws ec2 associate-address --instance-id $last_instance_id --public-ip $3 --output text 

# wget / chmod / execute

echo "** Attempting to download script..."
wget -N $git_url/ubuntu-server/retry-ssh.sh -P ~/bin

echo "** Setting script permissions..."
chmod -v +x ~/bin/retry-ssh.sh

echo "** Attempting to execute script..."
~/bin/retry-ssh.sh "-i $key_path ubuntu@$3"

# wget / chmod

echo "** Attempting to download script..."
wget -N $git_url/ubuntu-server/basic-install.sh -P ~/bin

echo "** Setting script permissions..."
chmod -v +x ~/bin/basic-install.sh

echo "** Setting hostname in script..."
sed -i "s/hostname.example1.com/$1/g" ~/bin/basic-install.sh

# ssh

echo "** Attemping to SCP script to server..."
scp -i $key_path ~/bin/basic-install.sh ubuntu@$3:~/basic-install

echo "** Once logged in, run:"
echo "** /home/ubuntu/basic-install"

echo "** Attempting to SSH into server..."
ssh -i $key_path ubuntu@$3

exit 0
