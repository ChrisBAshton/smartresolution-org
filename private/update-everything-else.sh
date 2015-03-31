#!/bin/bash

# can call this script from anywhere, we're correcting the path dynamically
my_dir="$(dirname "$0")"
"$my_dir/update-zip-and-documentation.sh"
"$my_dir/update-demo-version.sh"
"$my_dir/update-dependencies.sh"