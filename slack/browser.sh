#!/usr/bin/env bash
set -Eeuo pipefail

url="$*"

if
	zenity --question \
		--no-wrap \
		--no-markup \
		--text=$'Browser requested for:\n\n'"$url"$'\n\nCopy URL to clipboard?'
then
	xclip -selection clipboard <<<"$url"
fi
