#!/usr/bin/env bash

# http://www.debuntu.org/how-to-create-a-mysql-database-and-set-privileges-to-a-user/

if [ "$1" == "ls" ]
then
    mysql -D SOME_DATABASE -u root -p -e "select ID, user_login from SOME_DATABASE.SOME_TABLE;"
    exit 0
fi

if [ -z "$1" ]
then
    read -p "Input new db name / user name: " db_name
fi

read -s -p "Input new db password: " db_pw

echo -e "\n\n** Input root password..."

mysql -u root -p -e "create database $1;
grant usage on *.* to $1@localhost identified by '$db_pw';
grant all privileges on $1.* to $1@localhost;"

echo "** Check newly-made credentials..."
mysql -u $1 -p "$db_pw" $1

exit 0
