#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with sudo: sudo bash $0"
  exit 1
fi

UNWANTED=(
  af.pak am.pak ar.pak bg.pak bn.pak ca.pak cs.pak da.pak
  de.pak el.pak es-419.pak es.pak et.pak fa.pak fil.pak fi.pak
  fr.pak gu.pak he.pak hi.pak hr.pak hu.pak id.pak it.pak
  ja.pak ka.pak kn.pak ko.pak lt.pak lv.pak ml.pak mr.pak ms.pak
  nb.pak nl.pak pl.pak pt-BR.pak pt-PT.pak ro.pak ru.pak
  sk.pak sl.pak sr.pak sv.pak sw.pak ta.pak te.pak th.pak
  tr.pak ur.pak vi.pak zh-CN.pak zh-TW.pak
)

APPS=(
  "/usr/share/windsurf:Windsurf"
  "/usr/share/cursor:Cursor"
  "/usr/share/code:VSCode"
  "/usr/share/codium:VSCodium"
  "/usr/share/antigravity/:Antigravity"
)

FACTS=(
  "Did you know? Chromium's LICENSES.chromium.html can be over 15MB — bigger than some entire web apps!"
  "Fun fact: Chromium is maintained by over 1,000 contributors and has millions of lines of code."
  "Fun fact: The .pak file format used for locales is a custom binary archive format developed by Google."
  "Did you know? VSCode has over 50 million monthly active users — that's more than the population of South Africa!"
  "Fun fact: Electron, the framework powering these IDEs, bundles an entire Chromium browser. Your IDE literally IS a browser."
  "Did you know? There are 54 locale files in a typical Chromium-based app — you're keeping English and ditching the rest!"
  "Fun fact: The first version of VSCode was released in 2015. It went from zero to the world's most popular IDE in under 5 years."
  "Did you know? Cursor, Windsurf, and VSCodium are all forks of VSCode — open source really does make the world go round."
)

TOTAL_BYTES_SAVED=0

print_fact() {
  local idx=$((RANDOM % ${#FACTS[@]}))
  echo ""
  echo "  >> ${FACTS[$idx]}"
  echo ""
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

remove_locales() {
  local app_dir="$1"
  local locales_dir="$app_dir/locales"
  local bytes_saved=0

  if [ ! -d "$locales_dir" ]; then
    echo "  Locales dir not found, skipping: $locales_dir"
    return
  fi

  echo "  Removing unwanted locales from $locales_dir..."
  cd "$locales_dir" || return
  local count=0
  for pak in "${UNWANTED[@]}"; do
    if [ -f "$pak" ]; then
      local fsize
      fsize=$(stat -c%s "$pak" 2>/dev/null || stat -f%z "$pak" 2>/dev/null)
      rm "$pak" && ((count++)) && ((bytes_saved += fsize))
    fi
  done

  TOTAL_BYTES_SAVED=$((TOTAL_BYTES_SAVED + bytes_saved))
  echo "  Removed $count locale files, saving $(bytes_to_human $bytes_saved)."
  echo "  Remaining locales: $(ls *.pak 2>/dev/null | tr '\n' ' ')"
  print_fact
}

remove_license() {
  local license_file="$1/LICENSES.chromium.html"
  if [ -f "$license_file" ]; then
    local fsize
    fsize=$(stat -c%s "$license_file" 2>/dev/null || stat -f%z "$license_file" 2>/dev/null)
    rm "$license_file" && echo "  Removed: $license_file ($(bytes_to_human $fsize) freed)"
    TOTAL_BYTES_SAVED=$((TOTAL_BYTES_SAVED + fsize))
  else
    echo "  Skipped (not found): $license_file"
  fi
}

echo "================================================"
echo "  IDE Locale & License Cleaner"
echo "  Checking for Windsurf, Cursor, VSCode, VSCodium"
echo "================================================"

found=0
for entry in "${APPS[@]}"; do
  app_dir="${entry%%:*}"
  app_name="${entry##*:}"
  echo ""
  if [ -d "$app_dir" ]; then
    echo "Found $app_name at $app_dir"
    ((found++))
    remove_locales "$app_dir"
    remove_license "$app_dir"
  else
    echo "Not installed, skipping: $app_name ($app_dir)"
  fi
done

echo ""
echo "================================================"
if [ "$found" -eq 0 ]; then
  echo "  No supported IDEs found. Nothing to clean."
else
  echo "  All done! Cleaned $found IDE(s)."
  echo "  Total space saved: $(bytes_to_human $TOTAL_BYTES_SAVED)"
fi
echo "================================================"
