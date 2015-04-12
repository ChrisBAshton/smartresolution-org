#!/bin/bash

cd /home/ec2-user

# remove old version of SmartResolution if we've done this before
sudo rm -rf html-demo

# get latest version of SmartResolution
wget https://github.com/ChrisBAshton/smartresolution/archive/master.zip
unzip master.zip
rm master.zip
mv smartresolution-master/ html-demo

# move into the repo, ready to run some scripts
cd html-demo

# remove AWS' default php 5.3, install php 5.4
sudo yum remove httpd* php* -y
sudo yum install httpd24 php54 php54-pdo php54-mysqlnd -y

## install composer
curl -sS https://getcomposer.org/installer | php

# install project dependencies
php composer.phar install

# make project dependencies available to path
export PATH=./vendor/bin:$PATH

# create our database
sqlite3 data/production.db < data/db.sql

# populate with demo values
php data/fixtures/seed.php production

# also need to give our database permissions (@TODO - 777 is probably a bad idea)
sudo chown -R apache:apache /home/ec2-user/html-demo
chmod 777 data
chmod 777 data/production.db
chmod 777 webapp/modules/