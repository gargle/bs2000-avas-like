#!/bin/bash

# log and exit if there is an error
set -ex

echo read a file and display its contents
export DD_FILE_IN=./la10a.fil

cat <<END_OF_INPUT |
Johan
END_OF_INPUT
./la10a

