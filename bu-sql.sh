#!/bin/sh
####################################
#
# Backup SQL
#
# http://thegeekstuff.com/2008/09/backup-and-restore-mysql-database-using-mysqldump/
#
####################################

# Create archive filename.
day=$(date +%A)
hostname=$(hostname -s)
sql_file="$hostname-$day.sql"
dest="/home/ubuntu/backups"

# Print start status message.
echo "Backing up SQL"
date
echo

# Backup the file using mysqldump
sudo mysqldump -u root -p 'password' --all-databases > /tmp/$

# Copy the file over
sudo cp /tmp/all-data.sql $dest/$sql_file

# Print end status message.
echo
echo "Backup finished"
date

# Long listing of files in $dest to check file sizes.
ls -lh $dest
