#!/bin/bash

cd /home/ec2-user/html

# remove repo if it already exists
rm -rf smartresolution
# also remove current zip
rm -f ./downloads/smartresolution.zip

# get latest version of SmartResolution
wget https://github.com/ChrisBAshton/smartresolution/archive/master.zip
unzip master.zip
rm master.zip
mv smartresolution-master/ smartresolution/

# Update API documentation
rm -rf /home/ec2-user/html/docs/

#################################################### DOCS

curl -sS https://getcomposer.org/installer | php
php composer.phar install

export PATH=/home/ec2-user/html/vendor/bin:$PATH
sudo chmod 700 /home/ec2-user/html/vendor/bin/phpdoc
sudo chown -R ec2-user /tmp
phpdoc -d /home/ec2-user/html/smartresolution/webapp/ -t /home/ec2-user/html/docs/
phpdoc -d /home/ec2-user/html/smartresolution/webapp/core/api/ -t /home/ec2-user/html/module-docs/

# delete any directories we don't need
cd smartresolution
rm -rf features
rm -rf modules
rm -rf test
rm -rf vendor # we needed this just now for the phpdoc stuff, but this amounts to MB of stuff!

# likewise, delete any files we don't need
rm README.md
rm Gemfile
rm Gemfile.lock
rm composer.lock

# initialise empty database
sqlite3 data/production.db < data/db.sql

cd /home/ec2-user/html/

# zip, then remove tmp directory
#################################################### ZIP
mkdir downloads
zip -r ./downloads/smartresolution.zip smartresolution/
rm -rf smartresolution