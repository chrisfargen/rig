# Ubuntu Server Notes

bla bla bla

## Packages

- vim
- git
- rdiff-backup
- nginx
- mysql
- php
- ruby
- rails

## Local Scripts

- fargen-site

/usr/local/bin/dl-run-make-server

Typical procedure:

1. Run `/usr/local/bin/dl-run-make-server`
2. SSH into the server
3. Run `./basic-install` 

Installation is interactive at times.
Among other things, the script
will ask for the following:

- login username
- login password
- mysql root password

Then, start server with:
`sudo service nginx start`

To add a site:
`fargen-site add [site-name]`

To unlock site for editing:
`cd /var/www/[site-name]/htdocs ; unlock
