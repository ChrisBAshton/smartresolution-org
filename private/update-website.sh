#!/bin/bash

# delete smartresolution.org
cd /var/www
sudo rm -rf html
sudo rm -rf html-demo

cd /home/ec2-user
sudo rm -rf html

# get the latest version
wget https://github.com/ChrisBAshton/smartresolution-org/archive/master.zip
unzip master.zip
rm master.zip
mv smartresolution-org-master/ html

./html/private/update-everything-else.sh

sudo ln -s /home/ec2-user/html      /var/www/html
sudo ln -s /home/ec2-user/html-demo /var/www/html-demo