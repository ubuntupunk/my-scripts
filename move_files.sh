#!/bin/bash

read -p "Enter file name: " file_name
read -p "Enter destination directory: " dest_dir

find . -maxdepth 1 -type f -name "$file_name" -exec mv -n {} "$dest_dir" \;
