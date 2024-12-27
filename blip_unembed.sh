#!/bin/sh
#
# Blip Unembed - converts blip.tv embed URL to original blip.tv URL and FLV URL
#                or original blip.tv URL to FLV URL and then downloads FLV file
#
# Copyright (C) 2008  Denver Gingerich
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.


print_usage()
{
	echo "Blip Unembed v0.1"
	echo "by Denver Gingerich (http://ossguy.com/)"
	echo
	echo "Usage: $0 http://blip.tv/play/<embed_id>"
	echo "  OR   $0 http://blip.tv/file/<orig_id>"
}

if [ $# -ne 1 ]; then
	print_usage
	exit 1
fi

which curl
if [ $? -ne 0 ]; then
	echo "Blip Unembed requires curl.  Please install curl and try again."
	exit 2
fi

echo $1 | grep play
if [ $? -eq 0 ]; then
	# URL is of the form http://blip.tv/play/<embed_id> so it's an embed URL
	EMBED_URL=$1

	EMBED_REDIRECT=`curl $EMBED_URL`

	XML_URL=http://`echo $EMBED_REDIRECT | sed -e 's/^.*file=http%3A%2F%2F\([^&]*\)&amp.*$/\1/g'`

	VIDEO_XML=`curl $XML_URL`
	BLIP_URL=`echo $VIDEO_XML | sed -e 's/^.*<media:player url="\([^"]*\)".*$/\1/g'`
	BLIP_FLV=`echo $VIDEO_XML | sed -e 's/^.*<media:content url="\([^"]*\)"[^>]*type="video\/x-flv"[^>]*>.*$/\1/g'`
else
	echo $1 | grep file
	if [ $? -eq 0 ]; then
		# URL is of the form http://blip.tv/file/<orig_id> so it's an original URL
		BLIP_URL=$1
		VIDEO_HTML=`curl $BLIP_URL | grep 'Flash Video'`

		BLIP_FLV=`echo $VIDEO_HTML | sed -e 's/^.*"Flash Video (.flv)", "attribute" : "\([^"]*\)".*$/\1/g'`
	else
		print_usage
		exit 3
	fi
fi

echo
echo Original URL: $BLIP_URL
echo FLV URL: $BLIP_FLV
echo
echo Downloading FLV file to `basename $BLIP_FLV`

curl -L $BLIP_FLV > `basename $BLIP_FLV`
