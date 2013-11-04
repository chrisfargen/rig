Server
===

## Linux

### Create Amazon EC2 instance.

### Install the LAMP stack.

```
# From a clean install...

# Update existing packages
sudo apt-get update

# Install tasksel for quick LAMP installation
sudo apt-get install tasksel

# Run tasksel and follow the prompts to install LAMP server
sudo tasksel

```

### Install zip package.

```
sudo apt-get install zip
```

### Create backup script for files.

  - See tutorial on [help.ubuntu.com](https://help.ubuntu.com/lts/serverguide/backup-shellscripts.html).

### Back up to DropBox.

  - See tutorial on [blog.justin.kelly.org.au](http://blog.justin.kelly.org.au/commandline-dropbox-client/).

## Apache

### Enable Apache rewrite module.

  - Check enabled Apache modules.

```
apache2ctl -M
```

  - If `rewrite` is not listed, enable it.

```
sudo a2enmod rewrite
```

  - See [help.ubuntu.com](https://help.ubuntu.com/community/EnablingUseOfApacheHtaccessFiles) or [drupal.org](https://drupal.org/node/134439).

### Set up SSL.

  - For something that actually worked, see [digitalocean.com](https://www.digitalocean.com/community/articles/how-to-create-a-ssl-certificate-on-apache-for-ubuntu-12-04).
  
  - For something else that seems relevant, see [forums.aws.amazon.com](https://forums.aws.amazon.com/message.jspa?messageID=361027).
  
  - Allow overlapping SSL sites(?). See [stackoverflow.com](http://stackoverflow.com/questions/10658017/apache-error-default-virtualhost-overlap-on-port-443).
  
  - Redirect HTTP to HTTPS.
  
    - For how to set up the config file, see [blog.edwards-research.com](http://blog.edwards-research.com/2010/02/force-apache2-to-redirect-from-http-to-https/).
  
    - Redirect code. See [wiki.apache.org](http://wiki.apache.org/httpd/RewriteHTTPToHTTPS).

### Change the host name.

  - See tutorial on [makeuseof.com](http://www.makeuseof.com/tag/change-computer-ubuntu-1010/).

### Change the document root.

  - See tutorial on [ajopaul.com](http://www.ajopaul.com/2010/05/01/ubuntu-apache2-change-default-documentroot-varwww/).

### Set up a new site in Apache.

- See tutorial on [digitalocean.com](https://www.digitalocean.com/community/articles/how-to-set-up-apache-virtual-hosts-on-ubuntu-12-04-lts).

### Add basic authentication to a directory.

- See wiki on [wiki.apache.org](http://wiki.apache.org/httpd/PasswordBasicAuth).

## MySQL

### <del>Change the MYSQL root username.</del>

### Create new MySQL user.

```
# Log in to MySQL via command-line
mysql -u root -p

```

  - See tutorial on [digitalocean.com](https://www.digitalocean.com/community/articles/how-to-create-a-new-user-and-grant-permissions-in-mysql).

```
mysql -u root -p
```

### Install PHPMyAdmin.

```
# Navigate to /var/www/
cd /var/www

# Download
sudo wget http://sourceforge.net/projects/phpmyadmin/files/phpMyAdmin/4.0.4.1/phpMyAdmin-4.0.4.1-all-languages.tar.gz

# Expand
sudo tar -zxvf phpMyAdmin-4.0.4.1-all-languages.tar.gz

# Clean up
sudo rm -rf phpMyAdmin-4.0.4.1-all-languages.tar.gz

# Rename
sudo mv phpMyAdmin-4.0.4.1-all-languages pma

```

  - Set up phpMyAdmin `config.inc.php` (see `config.inc.php` file in this repo).

    - Remove timeout.
    
    - Remove password prompt.

## Wordpress

### Install the latest version of Wordpress.

```
# Navigate to the web directory
cd /home/web

# Download the latest wordpress
sudo wget http://wordpress.org/latest.tar.gz

# Expand tar.gz file
sudo tar -zxvf latest.tar.gz

# Rename the expanded directory
sudo mv wordpress mysite

# Set up config file

```

  - Create database and user in phpMyAdmin. See tutorial at [codex.wordpress.org](http://codex.wordpress.org/Installing_WordPress#Step_2:_Create_the_Database_and_a_User).
  
  - Make username semantic and password random.
  
### Set up `wp-config.php`.
  
  - Create a new SQL user and database.
  
  - Copy that info into `wp-config.php`.
  
  - Generate keys at [api.wordpress.org](http://api.wordpress.org/secret-key/1.1/salt).
  
### Install the 'bones' theme.

  - See [themble.com](http://themble.com/bones) for the latest.

```
# Download bones
sudo wget https://github.com/eddiemachado/bones/zipball/master
```

## PHP

### Download RedBeanPHP.

- Download from [redbeanphp.com](http://redbeanphp.com/downloadredbean.php).

## JavaScript

  - Test drive a backbone.js app.
  
  - Download from [github](https://github.com/tastejs/todomvc/tree/gh-pages/architecture-examples/backbone).

## Notes

- Learn about Unix directory structure on [wikipedia.com](https://en.wikipedia.org/wiki/Unix_directory_structure).

- File Permissions

  - Learn about Unix file permissions on [dartmouth.edu](http://www.dartmouth.edu/~rc/help/faq/permissions.html).

  - Learn about Wordpress-specific permissions on [codex.wordpress.org](http://codex.wordpress.org/Changing_File_Permissions).

- Learn about SSL on [httpd.apache.org](http://httpd.apache.org/docs/current/ssl/ssl_howto.html#intranet).

Here is my ideal server setup.

### Software

| Category      | Component       | Cost  |
| ------------- |:---------------:| -----:|
| OS            | Ubuntu Server   | 0     |
| text editor   | Vim             | 0     |
| installer     | Tasksel         | 0     |
| http server   | Apache          | 0     |
| sql server    | MySQL           | 0     |
| server script | PHP             | 0     |
| db manager    | PHPMyAdmin      | 0     |
| archiving     | zip             | 0     |

### File Structure

```
/
  home
    includes
      rb
        example.php
        license.txt
        rb.php
      db-config.php
    ubuntu
      backups
    web
      chrisfargen
      phpmyadmin
```
### Directories

| path                          | description            |
|-------------------------------|------------------------|
| /home/web                     | document root          |
| /home/ubuntu/backups          | backups                |
| /usr/bin                      | non-essential binaries |
| /etc/apache2/sites-available/ | apache site configs    |
