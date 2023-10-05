#!/bin/bash

# log and exit if there is an error
set -ex

echo read a file and display its contents
export DD_FILE_IN=./la10a.fil

echo "Johan" | ./la10a
