#!/bin/sh
#
#
# Get Comics strips
#
# by PhrankDaChicken
#
# http://ubuntu.online02.com

OP_FOLDER="/home/$USER/Desktop"


ucomic () {
# ucomic ( NAME )
NAME="$1"
YEAR=$(date +%Y)
YMD=$(date +%y%m%d)
wget "http://images.ucomics.com/comics/"$NAME"/"$YEAR"/"$NAME$YMD".gif" -O "$OP_FOLDER/$NAME.gif"
}

comics () {
DAY=$(date +%Y-%m-%d)
NAME="$1"
wget "http://comics.com/"$NAME"/"$DAY"/" -O "/tmp/"$NAME".html"
IMAGE=$(cat /tmp/$NAME.html | grep "/dyn/str_strip" | tail -n 1 | sed 's/gif.*/gif/g' | sed 's/.*src\=\"//g')
wget "$IMAGE" -O "$OP_FOLDER/$NAME.gif"
rm "/tmp/"$NAME".html"
}

arcamax () {
NAME="$1"
wget "http://www.arcamax.com/"$NAME -O "/tmp/"$NAME".html"
IMAGE=$(cat "/tmp/"$NAME".html" | grep "newspics" | sed 's/.*src\=\"//g' | sed 's/gif.*/gif/g')
wget "$IMAGE" -O  "$OP_FOLDER/$NAME.gif"
rm  "/tmp/"$NAME".html"
}

dilbert () {
DAY=$(date +%Y-%m-%d)
wget "http://dilbert.com/strips/comic/"$DAY -O /tmp/dilbert.html
IMAGE=$(cat /tmp/dilbert.html | grep "str_strip" | tail -n 1 | sed 's/gif.*/gif/g' | sed 's/.*src\=\"//g')
wget "$IMAGE" -O "$OP_FOLDER/dilbert.gif"
}

# Delete old comics
rm $OP_FOLDER/*.gif

# Get them comics from different websites
arcamax "zits"
arcamax "babyblues"
arcamax "familycircus"
arcamax "beetlebailey"
arcamax "blondie"
arcamax "hagarthehorrible"
arcamax "nonsequitur"

ucomic "ba"
ucomic "fb"
ucomic "crbc"
ucomic "cl"
ucomic "ga"
ucomic "crobh"
ucomic "crwiz"
ucomic "zi"
ucomic "pr"
ucomic "ch"
ucomic "wppic"

comics "pearls_before_swine"
comics "peanuts"
comics "get_fuzzy"

dilbert

TIMESTAMP=$(date +%m%d)
touch -m -t $TIMESTAMP"2000" $OP_FOLDER/*.gif

# End of Script
