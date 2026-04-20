#!/bin/bash

# Copyright (c) 2024 @ubuntupunk. All rights reserved.
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation.

username=$(whoami)

function check_app {
  proc="$(ps aux | grep $username | grep -v $0 | grep $1 | grep -v grep)"
  if [ "$proc" != "" ]; then
    echo "!!! Shutdown $1 first!"
    exit 1
  fi
}

function vacuum_mozillas {
  echo "Vacuuming $1..."
  find $2 -type f -name '*.sqlite' -exec sqlite3 -line {} VACUUM \;
}

check_app firefox
check_app thunderbird
vacuum_mozillas firefox ~/.mozilla/firefox/
vacuum_mozillas thunderbird ~/.thunderbird

echo 'Done!'

