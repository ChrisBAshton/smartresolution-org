## Pre-requisites
Your server needs to support the following:

* PHP (version >= 5.4)
* Composer (version >= 1.0)
* SQLite3 (version >= 3.7)

## Installation
First of all, [download](/download) SmartResolution and unzip the archive.

All of the commands in the rest of this README are relative to the root of the repository. Therefore, when you've downloaded the repo, make sure you `cd smartresolution` to go into the top level of the repository before running any of the following commands.

I've made a handy one-line installer script which installs all dependencies and creates and populates the database. You should run that script OR the manual installation - not both.

### Manual installation

```bash
# install dependencies with Composer 
composer install

# create production database
sqlite3 data/production.db < data/db.sql

# (optional) populate with demo values
php data/fixtures/seed.php production
```

### Maintenance
If you ever need to clear your database and go back into demo mode:

```
rm data/production.db
sqlite3 data/production.db < data/db.sql
php data/fixtures/seed.php production
```

## Seeing is believing
* run `php -S 127.0.0.1:8000 -t webapp` to start the server
* go to http://127.0.0.1:8000/ in your browser
* you should now see SmartResolution

## Deploying to your server
Because of the directory structure of the software, by default you'd need to direct visitors to /webapp, i.e. `http://example.com/webapp`

Most of the time, you'll want SmartResolution to be accessible at the root, i.e. `http://example.com`. To do this, you can edit your server's httpd.conf, or edit your .htaccess file, with this line:

```
DocumentRoot "/path/to/smartresolution/webapp"
```