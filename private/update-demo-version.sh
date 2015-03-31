#!/bin/bash

cd /var/www

# remove old version of SmartResolution if we've done this before
sudo rm -rf html-demo

# get latest version of SmartResolution
wget https://github.com/ChrisBAshton/smartresolution/archive/master.zip
unzip master.zip
rm master.zip
mv smartresolution-master/ html-demo

# move into the repo, ready to run some scripts
cd html-demo

function fix_permissions {
    sudo chown -R root:www /var/www
    sudo chmod 2775 /var/www
    find /var/www -type d -print0      | sudo xargs -0 chmod 2775
    find /var/www -type f -print0      | sudo xargs -0 chmod 0664
    # but we want smartresolution-org scripts to be executable
    find /var/www -name "*.sh" -print0 | sudo xargs -0 chmod u+x
}

cd /var/www/html-demo

# remove AWS' default php 5.3, install php 5.4
sudo yum remove httpd* php* -y
sudo yum install httpd24 php54 php54-pdo php54-mysqlnd -y

fix_permissions

## install composer
curl -sS https://getcomposer.org/installer | php

# install project dependencies
php composer.phar install

# make project dependencies available to path
export PATH=./vendor/bin:$PATH

# run our install script
sudo php deploy/install.php

fix_permissions # ...again

# also need to give our database permissions (@TODO - 777 is probably a bad idea)
sudo chown -R ec2-user /var/www/html-demo/data/
chmod 777 data
chmod 777 data/production.db

sudo service httpd start