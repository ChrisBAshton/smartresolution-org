
cd /var/www/html

## install composer
curl -sS https://getcomposer.org/installer | php

# install project dependencies
php composer.phar install

# make dependencies bin available
export PATH=./vendor/bin:$PATH

cd -