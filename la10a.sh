#!/bin/bash

# log and exit if there is an error
set -ex

# echo ask for a username and read a file DD_FILE_IN and display its contents

# the file to display
export DD_FILE_IN=./la10a.fil

cat <<END_OF_INPUT |
Johan
END_OF_INPUT
./la10a

