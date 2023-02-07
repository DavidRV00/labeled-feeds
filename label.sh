#!/bin/sh

# TODO:
# - do it on-demand by editing new-line file

url="$1"

get_title() {
	XDG_DATA_HOME=~/.config/bookmarks/feeds-test buku --nostdin --sall "$1" -f 3 \
		| awk -F'\t' '{print $2}'
}

title="$(get_title "$url")"
if [ -z "$title" ]; then
	bukuadd --db feeds-test "$url" feed
	title="$(get_title "$url")"
fi

oldline="$(grep "$url" "$HOME/.config/newsboat/urls")"
newline="$(printf "%s\t# %s\n" "$oldline" "$title")"

escape_input() {
	echo "$1"
}
escape_output() {
	echo "$1" | sed 's/&/\\\&/g'
}
oldline_escaped="$(escape_input "$oldline")"
newline_escaped="$(escape_output "$newline")"

sed -i "s|$oldline_escaped|$newline_escaped|g" "$HOME/.config/newsboat/urls"
