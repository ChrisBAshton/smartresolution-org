
cd /var/www/html

## install composer
curl -sS https://getcomposer.org/installer | php

# install project dependencies
php composer.phar install

# make dependencies bin available
export PATH=./vendor/bin:$PATH

sudo -i
sudo echo '
# VIRTUALHOST CONFIGURATION

NameVirtualHost *:80

<VirtualHost *:80>
    DocumentRoot /var/www/html
    ServerName  www.smartresolution.org
    ServerAlias smartresolution.org
</VirtualHost>

<VirtualHost *:80>

   ServerName   demo.smartresolution.org
   DocumentRoot /var/www/html-demo/webapp

   <Directory "/var/www/html-demo">
      Options Indexes FollowSymLinks MultiViews
      AllowOverride All
      Order allow,deny
      allow from all
   </Directory>

</VirtualHost>

<Directory "/var/www">
    AllowOverride All
    Require all granted
</Directory>

# Further relax access to the document roots:
<Directory "/var/www/html">
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
</Directory>
<Directory "/var/www/html-demo">
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
</Directory>

' > /etc/httpd/conf.d/subdomains.conf
exit # exit the root session

sudo service httpd restart

cd -