#!/bin/bash

# $1 is intended host name
# $2 is elastic ip address
# $3 is name of key pair

# Time to wait for instance to initiate
instance_wait="90s"

# Path to key file
key_path=$(echo ~)/.ssh/$3.pem

# http://stackoverflow.com/a/192337/1351736
me="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"

#
git_url="https://raw.github.com/chrisfargen/rig/master/ubuntu-server"

# Outputting variables
cat <<EOM
** Intended host name: $1
** Elastic IP address: $2
** Name of key pair: $3
** Path to key: $key_path
EOM

# aws

echo "** Attempting to run instance..."
last_instance_id=$(\
    aws ec2 run-instances \
    --image-id "ami-6aad335a" \
    --key-name $3 \
    --instance-type "t1.micro" \
    --query "Instances[0].InstanceId" \
    | sed -e 's/^"//'  -e 's/"$//')

echo "** Instance id: $last_instance_id"

echo "** Attempting to associate address $2..."
aws ec2 associate-address --instance-id $last_instance_id --public-ip $2 --output text

echo "** Attempting to create name tag $1..."
aws ec2 create-tags --resources $last_instance_id --tags Key=Name,Value=$1 --output text

#echo "** Attempting to terminate instance $last_instance_id..."
#aws ec2 terminate-instances --instance-ids $last_instance_id --output text

echo "** Clearing host fingerprint for address $2..."
ssh-keygen -f ~/.ssh/known_hosts -R $2

echo "** Clearing host fingerprint for address $1..."
ssh-keygen -f ~/.ssh/known_hosts -R $1

echo "** Sleeping $instance_wait while instance initiates..."
sleep $instance_wait

# wget / chmod / execute

echo "** Attempting to download script..."
wget -N $git_url/retry-ssh.sh -P ~/bin

echo "** Setting script permissions..."
chmod -v +x ~/bin/retry-ssh.sh

echo "** Attempting to execute script..."
~/bin/retry-ssh.sh "-i $key_path ubuntu@$2"

# wget / chmod

echo "** Attempting to download script..."
wget -N $git_url/basic-install.sh -P ~/bin

echo "** Setting script permissions..."
chmod -v +x ~/bin/basic-install.sh

#ssh

echo "** Attemping to SCP script to server..."
scp -i $key_path ~/bin/basic-install.sh ubuntu@$2:~/basic-install

echo "** Attempting to SSH into server..."
ssh -i $key_path ubuntu@$2

exit 0
