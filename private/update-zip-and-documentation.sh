#!/bin/bash

cd /var/www/html

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
rm -rf ./docs/

# install project dependencies
cd smartresolution
curl -sS https://getcomposer.org/installer | php
php composer.phar install
export PATH=./vendor/bin:$PATH

#################################################### DOCS
phpdoc -d ./webapp/ -t /var/www/html/docs/



# delete any directories we don't need
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

cd /var/www/html/

# zip, then remove tmp directory
#################################################### ZIP
mkdir downloads
zip -r ./downloads/smartresolution.zip smartresolution/
rm -rf smartresolution