#!/bin/bash

# Copyright (c) 2024 @ubuntupunk. All rights reserved.
## This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation.

# 1. Configuration
LOG_TARGETS=(
  "$HOME/.npm/_logs"
  "$HOME/.npm/_cacache/tmp"
  "$HOME/.gemini/tmp"
  "$HOME/.kimi/logs"
  "$HOME/.local/share/kilo/log"
  "$HOME/.local/share/opencode/log"
  "$HOME/.qwen/tmp"
  "$HOME/.cache/pip"
  "$HOME/.gem/specs"
)

# Define browsers
FIREFOX_CACHE="$HOME/.cache/mozilla/firefox"
FIREFOX_SNAP_CACHE="$HOME/snap/firefox/common/.cache/mozilla/firefox"
ZEN_CACHE="$HOME/.cache/zen/*/*.default-release/cache2"
#CHROME_CACHE="$HOME/.cache/google-chrome"
PNPM_CACHE="$HOME/.cache/pnpm"

# 2 logic to calculate total size of all targets in bytes
get_size() {
  local total=0
  for path in "$@"; do
    if [ -d "$path" ]; then
      # du -sb gets the size in bytes (summarized)
      size=$(du -sb "$path" 2>/dev/null | cut -f1)
      total=$((total + size))
    fi
  done
  echo "$total"
}

PRE_SIZE=$(get_size "${LOG_TARGETS[@]}" "$FIREFOX_CACHE" "$FIREFOX_SNAP_CACHE" "$ZEN_CACHE")

echo "--- Cron Housecleaning: $(date) ---"

# 3. Clean Standard Logs, always safe
for dir in "${LOG_TARGETS[@]}"; do
  if [ -d "$dir" ]; then
    rm -rf "${dir:?}"/*
    echo "Cleaned $dir"
  fi
done

#wipe metadata cache
if [ -d "$PNPM_CACHE" ]; then
  rm -rf "$PNPM_CACHE"/*
  echo "Cleaned $PNPM_CACHE"
fi

#4. Clean Browsers (only if closed)

#Check for Mozilla Firefox
if ! pgrep -x "firefox" >/dev/null; then
  FF_PATHS=("$FIREFOX_CACHE" "$FIREFOX_SNAP_CACHE")

  for ff_path in "${FF_PATHS[@]}"; do
    if [ -d "$ff_path" ]; then
      echo "Busting Firefox cache at $ff_path..."
      #target 'cache2' folders inside profile directories
      find "$ff_path" -type d \( -name 'cache2' -o -name "startupCache" \) -exec sh -c 'rm -rf "$1"/*' _ {} +
    else
      echo "Firefox cache directory $ff_path not found, skipping"
    fi
  done
else
  echo "Firefox is running, skipping cache cleanup"
fi

# Check for Zen (handles zen and zen-bin process names)
if ! pgrep -x "zen" >/dev/null && ! pgrep -x "zen-bin" >/dev/null; then
  if [ -d "$ZEN_CACHE" ]; then
    find "$ZEN_CACHE" -type d -name "cache2" -exec sh -c 'rm -rf "$1"/*' _ {} +
    echo "Cleaned Zen Cache"
  else
    echo "Zen cache directory not found, skipping"
  fi
else
  echo "Zen is running, skipping cache cleanup"
fi

# 5. Final Reporting

POST_SIZE=$(get_size "${LOG_TARGETS[@]}" "$FIREFOX_CACHE" "$FIREFOX_SNAP_CACHE" "$ZEN_CACHE" "$PNPM_CACHE")
SAVED_BYTES=$((PRE_SIZE - POST_SIZE))
# Convert bytes to human-readable format (MB)
SAVED_MB=$(echo "scale=2; $SAVED_BYTES / 1024 / 1024" | bc)

echo "--- Cleanup Complete ---"
echo "Space reclaimed: ${SAVED_MB} MB"
echo "------------------------"
