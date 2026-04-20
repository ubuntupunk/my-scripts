#!/bin/bash

# Copyright (c) 2024 @ubuntupunk. All rights reserved.
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation.

username=$(whoami)
proc="$(ps aux | grep $username | grep -v $0 | grep firefox | grep -v grep)"
if [ "$proc" != "" ]; then
  echo "shutdown firefox first!"
  exit 1
fi

curdir=$(pwd)

# Check both native and snap Firefox profile directories
PROFILE_DIRS=(
  "$HOME/.mozilla/firefox"
  "$HOME/snap/firefox/common/.mozilla/firefox"
)

for profile_base in "${PROFILE_DIRS[@]}"; do
  if [ -f "$profile_base/profiles.ini" ]; then
    for dir in $(cat "$profile_base/profiles.ini" | grep Path= | sed -e 's/Path=//'); do
      cd "$profile_base/$dir" 2>/dev/null
      if [ $? == 0 ]; then
        echo "In $(pwd)"
        echo -e "    running VACUUM...\n"

        for F in $(find . -type f -name '*.sqlite' -print); do
          sqlite3 $F "VACUUM;"
        done

        echo -e "Done in $(pwd)\n"
      else
        echo -e "\nCould not enter directory $dir, skipping it\n"
      fi
    done
  fi
done
echo "Job finished"

cd $curdir

