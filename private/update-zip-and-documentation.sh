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
export PATH=./vendor/bin:$PATH
phpdoc -d ./smartresolution/webapp/ -t /home/ec2-user/html/docs/

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