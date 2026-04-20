#!/bin/bash

# Copyright (c) 2024 @ubuntupunk. All rights reserved.
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation.

username=$(whoami)
proc_firefox="$(ps aux | grep $username | grep -v $0 | grep firefox | grep -v grep)"
proc_zen="$(ps aux | grep $username | grep -v $0 | grep -E "(zen|zen-bin)" | grep -v grep)"
if [ "$proc_firefox" != "" ] || [ "$proc_zen" != "" ]; then
  echo "Shutdown Firefox and/or Zen browser first!"
  exit 1
fi

curdir=$(pwd)

# Function to calculate total size of .sqlite and .db files in directories
get_sqlite_size() {
  local total=0
  for base_dir in "$@"; do
    if [ -d "$base_dir" ]; then
      # Find all .sqlite and .db files and sum their sizes
      while IFS= read -r -d '' file; do
        size=$(stat -c%s "$file" 2>/dev/null || stat -f%z "$file" 2>/dev/null)
        total=$((total + size))
      done < <(find "$base_dir" -type f \( -name "*.sqlite" -o -name "*.db" \) -print0)
    fi
  done
  echo "$total"
}

# Function to convert bytes to human readable
bytes_to_human() {
  local bytes=$1
  if [ "$bytes" -ge 1048576 ]; then
    echo "$((bytes / 1048576))MB (${bytes} bytes)"
  elif [ "$bytes" -ge 1024 ]; then
    echo "$((bytes / 1024))KB (${bytes} bytes)"
  else
    echo "${bytes} bytes"
  fi
}

# Calculate initial size of all .sqlite files
PRE_SIZE=$(get_sqlite_size "${PROFILE_DIRS[@]}" "${ZEN_PROFILE_DIRS[@]}" "$OPENCODE_DIR" "$KILO_DIR")

echo "--- Vacuuming Browser Databases: $(date) ---"

# Check both native and snap Firefox profile directories
PROFILE_DIRS=(
  "$HOME/.mozilla/firefox"
  "$HOME/snap/firefox/common/.mozilla/firefox"
)

# Zen browser profile directories
ZEN_PROFILE_DIRS=(
  "$HOME/.zen"
  "$HOME/.var/app/app.zen_browser.zen/.zen"
  "$HOME/snap/zen/common/.zen"
)

# Opencode directory
OPENCODE_DIR="$HOME/.local/share/opencode"

# Kilo directory
KILO_DIR="$HOME/.local/share/kilo"

for profile_base in "${PROFILE_DIRS[@]}"; do
  if [ -f "$profile_base/profiles.ini" ]; then
    for dir in $(cat "$profile_base/profiles.ini" | grep Path= | sed -e 's/Path=//'); do
      cd "$profile_base/$dir" 2>/dev/null
      if [ $? == 0 ]; then
        echo "In $(pwd)"
        echo -e "    running VACUUM...\n"

          for F in $(find . -type f \( -name '*.sqlite' -o -name '*.db' \) -print); do
            sqlite3 $F "VACUUM;"
          done

        echo -e "Done in $(pwd)\n"
      else
        echo -e "\nCould not enter directory $dir, skipping it\n"
      fi
    done
  fi
done

# Process Zen browser profiles
for profile_base in "${ZEN_PROFILE_DIRS[@]}"; do
  if [ -d "$profile_base" ]; then
    # Zen may not have profiles.ini, find profile directories directly
    for profile_dir in "$profile_base"/*/; do
      if [ -d "$profile_dir" ]; then
        cd "$profile_dir" 2>/dev/null
        if [ $? == 0 ]; then
          echo "In Zen $(pwd)"
          echo -e "    running VACUUM...\n"

          for F in $(find . -type f \( -name '*.sqlite' -o -name '*.db' \) -print); do
            sqlite3 $F "VACUUM;"
          done

          echo -e "Done in Zen $(pwd)\n"
        else
          echo -e "\nCould not enter Zen directory $profile_dir, skipping it\n"
        fi
      fi
    done
  fi
done

# Process Opencode SQLite files
if [ -d "$OPENCODE_DIR" ]; then
  cd "$OPENCODE_DIR" 2>/dev/null
  if [ $? == 0 ]; then
    echo "In Opencode $(pwd)"
    echo -e "    running VACUUM...\n"

    for F in $(find . -type f \( -name '*.sqlite' -o -name '*.db' \) -print); do
      sqlite3 $F "VACUUM;"
    done

    echo -e "Done in Opencode $(pwd)\n"
  else
    echo -e "\nCould not enter Opencode directory $OPENCODE_DIR, skipping it\n"
  fi
fi

# Process Kilo SQLite files
if [ -d "$KILO_DIR" ]; then
  cd "$KILO_DIR" 2>/dev/null
  if [ $? == 0 ]; then
    echo "In Kilo $(pwd)"
    echo -e "    running VACUUM...\n"

    for F in $(find . -type f \( -name '*.sqlite' -o -name '*.db' \) -print); do
      sqlite3 $F "VACUUM;"
    done

    echo -e "Done in Kilo $(pwd)\n"
  else
    echo -e "\nCould not enter Kilo directory $KILO_DIR, skipping it\n"
  fi
fi

# Calculate final size and report savings
POST_SIZE=$(get_sqlite_size "${PROFILE_DIRS[@]}" "${ZEN_PROFILE_DIRS[@]}" "$OPENCODE_DIR" "$KILO_DIR")
SAVED_BYTES=$((PRE_SIZE - POST_SIZE))

echo "--- Vacuum Complete ---"
echo "Space reclaimed: $(bytes_to_human $SAVED_BYTES)"
echo "-------------------------"

cd $curdir

