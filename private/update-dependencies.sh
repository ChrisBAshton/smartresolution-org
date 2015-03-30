
cd /var/www/html

## install composer
curl -sS https://getcomposer.org/installer | php

# install project dependencies
php composer.phar install

# make dependencies bin available
export PATH=./vendor/bin:$PATH

sudo -i
sudo echo '<VirtualHost *:80>
    DocumentRoot /var/www/html
    ServerName  www.smartresolution.org
    ServerAlias smartresolution.org
</VirtualHost>

<VirtualHost *:80>
   ServerName   demo.smartresolution.org
   DocumentRoot /var/www/html-demo
</VirtualHost>' > /etc/httpd/conf.d/subdomains.conf
exit

cd -