#!/usr/bin/env bash
set -Eeuo pipefail

# this is a script suitable for use as a "git difftool"

# git config --global difftool.diffoscope.cmd 'export LOCAL REMOTE && full-path-to/git-difftool.sh'

# inspired by but obviously heavily modified from https://lists.reproducible-builds.org/pipermail/diffoscope/2016-April/000193.html

[ -n "$LOCAL" ]
[ -n "$REMOTE" ]

args=(
	--rm
	--interactive
)
user="$(id -u)"
user+=":$(id -g)"
args+=( --user "$user" )

if [ -t 0 ] && [ -t 1 ]; then
	args+=( --tty )
fi

if [ "$LOCAL" != /dev/null ]; then
	fileLocal="$(readlink -ve "$LOCAL")"
	args+=( --mount "type=bind,src=$fileLocal,dst=$fileLocal,ro" )
else
	echo >&2 "$REMOTE is a new file (nothing to diff)"
	exit 1
fi
fileRemote="$(readlink -ve "$REMOTE")"
args+=( --mount "type=bind,src=$fileRemote,dst=$fileRemote,ro" )

exec docker run "${args[@]}" tianon/diffoscope diffoscope "$@" "$fileLocal" "$fileRemote"
