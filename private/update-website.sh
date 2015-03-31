#!/bin/bash

# delete smartresolution.org
cd /var/www
sudo rm -rf html

# get the latest version
wget https://github.com/ChrisBAshton/smartresolution-org/archive/master.zip
unzip master.zip
rm master.zip
mv smartresolution-org-master/ html

./html/private/update-everything-else.sh