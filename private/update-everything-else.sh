#!/bin/bash

# can call this script from anywhere, we're correcting the path dynamically
my_dir="$(dirname "$0")"
"sudo $my_dir/update-zip-and-documentation.sh"
"sudo $my_dir/update-demo-version.sh"
"sudo $my_dir/update-dependencies.sh"