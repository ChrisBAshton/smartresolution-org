#!/bin/bash

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
phpdoc -d ./smartresolution/webapp/ -t ./docs/

cd smartresolution

# delete any directories we don't need
rm -rf features
rm -rf modules
rm -rf test

# likewise, delete any files we don't need
rm README.md
rm Gemfile
rm Gemfile.lock
rm composer.lock

# initialise empty database
sqlite3 data/production.db < data/db.sql

cd -

# zip, then remove tmp directory
zip -r ./downloads/smartresolution.zip smartresolution/
rm -rf smartresolution
