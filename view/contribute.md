# Contribute

SmartResolution is currently under construction as a dissertation by [Chris Ashton](http://ashton.codes). As such, we are unable to have contributions from other developers at this stage.

When the dissertation has been fully submitted, we will be able to take pull requests from anyone interested in contributing to the project. When the time comes, please follow the below instructions to contribute to development.

## Pre-requisites

* PHP (version >= 5.4)
* Composer (version >= 1.0)
* SQLite3 (version >= 3.7)
* RubyGems (version >= 2.2.2)

## Installation

### Manual installation

* install dependencies with Composer (`composer install`)
* create production database: `sqlite3 data/production.db < data/db.sql`
* at this stage you can tweak `data/fixtures/seed.php` to populate the production database, or you can leave the database blank and fill in manually later.
* `gem install bundler`
* `bundle install`

## Steps to run on each terminal instance

You need to export the Composer packages to your PATH:

`export PATH=./vendor/bin:$PATH`

Unfortunately, this needs to be done every time you start a new terminal session. For a more permanent solution, you'd need to edit your `~/.bash_profile` and add a line specific to where your project lives, e.g:

`export PATH=/Users/ashton/Dropbox/uni_major_project/_codebase/vendor/bin:$PATH`

Running either of these steps allows you to run tests, generate documentation, etc, as if those packages were installed globally.

## Seeing is believing

* run `./deploy/server.sh` to start the server
* go to http://127.0.0.1:8000/ in your browser
* you should now be able to register an account and log in using the forms provided

## Running tests

Run the unit tests:

`phpunit test`

Run the Cucumber tests:

`cucumber features`

...or just leave it to [Travis](https://travis-ci.org/ChrisBAshton/major-project.svg?branch=master)!

## Architecture

* /data/ - contains fixture data for tests. This is also where the test and production SQLite3 databases reside (once they've been made).
* /features/ - contains my Cucumber features and Ruby step definitions.
* /modules/ - contains modules describing dispute types. Not much to see here yet, but this will one day encompass the 'Maritime Collision' dispute type.
* /test/ - contains my PHP unit tests.
* /vendor/ - automatically generated directory of dependencies, created by Composer.
* /webapp/ - contains the core ODR platform. Uses the MVCR compound design pattern.
    - /controller/ - contains the business logic for the system.
    - /model/ - contains my classes and utility functions.
    - /view/ - contains the user interface.
    - index.php - defines the environment and pulls in all dependencies.
    - routes.php - describes the routing between HTTP requests and controllers.
