#!/bin/bash

# Copyright (c) 2024 @ubuntupunk. All rights reserved.
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation.

# Ensure script is run with sudo
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with sudo: sudo bash $0"
  exit 1
fi

# Locales to remove (keeping en-GB.pak and en-US.pak)
UNWANTED=(
  af.pak am.pak ar.pak bg.pak bn.pak ca.pak cs.pak da.pak
  de.pak el.pak es-419.pak es.pak et.pak fa.pak fil.pak fi.pak
  fr.pak gu.pak he.pak hi.pak hr.pak hu.pak id.pak it.pak
  ja.pak ka.pak ko.pak lt.pak lv.pak ml.pak mr.pak ms.pak
  nb.pak nl.pak pl.pak pt-BR.pak pt-PT.pak ro.pak ru.pak
  sk.pak sl.pak sr.pak sv.pak sw.pak ta.pak te.pak th.pak
  tr.pak ur.pak vi.pak zh-CN.pak zh-TW.pak
)

# IDE app base directories
APPS=(
  "/usr/share/windsurf"
  "/usr/share/cursor"
  "/usr/share/code"
  "/usr/share/codium"
)

remove_locales() {
  local locales_dir="$1/locales"
  if [ ! -d "$locales_dir" ]; then
    echo "  Locales dir not found, skipping: $locales_dir"
    return
  fi
  echo "  Removing unwanted locales from $locales_dir..."
  cd "$locales_dir" || return
  for pak in "${UNWANTED[@]}"; do
    if [ -f "$pak" ]; then
      rm "$pak" && echo "    Removed: $pak"
    else
      echo "    Skipped (not found): $pak"
    fi
  done
  echo "  Remaining locales:"
  ls *.pak 2>/dev/null | tr '\n' ' '
  echo ""
}

remove_license() {
  local license_file="$1/LICENSES.chromium.html"
  if [ -f "$license_file" ]; then
    rm "$license_file" && echo "  Removed: $license_file"
  else
    echo "  Skipped (not found): $license_file"
  fi
}

for app in "${APPS[@]}"; do
  if [ -d "$app" ]; then
    echo ""
    echo "Found: $app"
    remove_locales "$app"
    remove_license "$app"
  else
    echo ""
    echo "Not installed, skipping: $app"
  fi
done

echo ""
echo "All done."
