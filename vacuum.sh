#!/bin/bash

# Copyright (c) 2024 @ubuntupunk. All rights reserved.
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation.

usage() {
  echo "Usage: $0 [OPTIONS]"
  echo "Options:"
  echo "  --firefox   Vacuum Firefox browser databases"
  echo "  --zen       Vacuum Zen browser databases"
  echo "  --opencode  Vacuum Opencode databases"
  echo "  --kilo      Vacuum Kilo databases"
  echo "  --all       Vacuum all supported databases (default)"
  echo "  -h, --help  Show this help message"
  exit 1
}

TARGETS=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --firefox)
      TARGETS="$TARGETS firefox"
      shift
      ;;
    --zen)
      TARGETS="$TARGETS zen"
      shift
      ;;
    --opencode)
      TARGETS="$TARGETS opencode"
      shift
      ;;
    --kilo)
      TARGETS="$TARGETS kilo"
      shift
      ;;
    --all)
      TARGETS="firefox zen opencode kilo"
      shift
      ;;
    -h|--help)
      usage
      ;;
    *)
      echo "Unknown option: $1"
      usage
      ;;
  esac
done

if [ -z "$TARGETS" ]; then
  TARGETS="firefox zen opencode kilo"
fi

username=$(whoami)
proc_firefox="$(ps aux | grep $username | grep -v $0 | grep firefox | grep -v grep)"
proc_zen="$(ps aux | grep $username | grep -v $0 | grep -E "(zen|zen-bin)" | grep -v grep)"
proc_kilo="$(ps aux | grep $username | grep -v $0 | grep kilo | grep -v grep)"
proc_opencode="$(ps aux | grep $username | grep -v $0 | grep opencode | grep -v grep)"

check_running() {
  local target=$1
  local proc_var="proc_$target"
  if [ "${!proc_var}" != "" ]; then
    echo "Shutdown $target first!"
    exit 1
  fi
}

for target in $TARGETS; do
  check_running "$target"
done

curdir=$(pwd)

get_sqlite_size() {
  local total=0
  for base_dir in "$@"; do
    if [ -d "$base_dir" ]; then
      while IFS= read -r -d '' file; do
        size=$(stat -c%s "$file" 2>/dev/null || stat -f%z "$file" 2>/dev/null)
        total=$((total + size))
      done < <(find "$base_dir" -type f \( -name "*.sqlite" -o -name "*.db" \) -print0)
    fi
  done
  echo "$total"
}

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

PRE_SIZE=0
PROFILE_DIRS=()
ZEN_PROFILE_DIRS=()
OPENCODE_DIR=""
KILO_DIR=""

for target in $TARGETS; do
  case "$target" in
    firefox)
      PROFILE_DIRS+=("$HOME/.mozilla/firefox")
      PROFILE_DIRS+=("$HOME/snap/firefox/common/.mozilla/firefox")
      ;;
    zen)
      ZEN_PROFILE_DIRS+=("$HOME/.zen")
      ZEN_PROFILE_DIRS+=("$HOME/.var/app/app.zen_browser.zen/.zen")
      ZEN_PROFILE_DIRS+=("$HOME/snap/zen/common/.zen")
      ;;
    opencode)
      OPENCODE_DIR="$HOME/.local/share/opencode"
      ;;
    kilo)
      KILO_DIR="$HOME/.local/share/kilo"
      ;;
  esac
done

PRE_SIZE=$(get_sqlite_size "${PROFILE_DIRS[@]}" "${ZEN_PROFILE_DIRS[@]}" "$OPENCODE_DIR" "$KILO_DIR")

echo "--- Vacuuming: $TARGETS - $(date) ---"

vacuum_dir() {
  local label=$1
  local dir=$2
  if [ -d "$dir" ]; then
    cd "$dir" 2>/dev/null
    if [ $? == 0 ]; then
      echo "In $label $(pwd)"
      echo -e "    running VACUUM...\n"

      for F in $(find . -type f \( -name '*.sqlite' -o -name '*.db' \) -print); do
        sqlite3 $F "PRAGMA wal_checkpoint(PASSIVE); VACUUM;"
      done

      echo -e "Done in $label $(pwd)\n"
    else
      echo -e "\nCould not enter directory $dir, skipping it\n"
    fi
  fi
}

for target in $TARGETS; do
  case "$target" in
    firefox)
      for profile_base in "${PROFILE_DIRS[@]}"; do
        if [ -f "$profile_base/profiles.ini" ]; then
          for dir in $(cat "$profile_base/profiles.ini" | grep Path= | sed -e 's/Path=//'); do
            vacuum_dir "Firefox" "$profile_base/$dir"
          done
        fi
      done
      ;;
    zen)
      for profile_base in "${ZEN_PROFILE_DIRS[@]}"; do
        if [ -d "$profile_base" ]; then
          for profile_dir in "$profile_base"/*/; do
            vacuum_dir "Zen" "$profile_dir"
          done
        fi
      done
      ;;
    opencode)
      vacuum_dir "Opencode" "$OPENCODE_DIR"
      ;;
    kilo)
      vacuum_dir "Kilo" "$KILO_DIR"
      ;;
  esac
done

POST_SIZE=$(get_sqlite_size "${PROFILE_DIRS[@]}" "${ZEN_PROFILE_DIRS[@]}" "$OPENCODE_DIR" "$KILO_DIR")
SAVED_BYTES=$((PRE_SIZE - POST_SIZE))

echo "--- Vacuum Complete ---"
echo "Space reclaimed: $(bytes_to_human $SAVED_BYTES)"
echo "-------------------------"

cd "$curdir"