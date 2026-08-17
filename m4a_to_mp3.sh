#!/usr/bin/env sh

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <input.m4a> <output.mp3>"
  exit 1
fi

ffmpeg -i "$1" -c:a libmp3lame -q:a 2 "$2"
