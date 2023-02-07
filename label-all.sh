#!/bin/sh

# TODO:
# - ignore already-done

urlsfile="$HOME/.config/newsboat/urls"

cp "$urlsfile" /tmp/newsboat-urls-bkp

grep "^http" "$urlsfile" | while read -r line; do
	./label.sh "$(echo "$line" | awk '{print $1}')"
done
