#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../.libs/deb-repo.sh"

json="$(
	uri='https://packagecloud.io/slacktechnologies/slack/debian'
	suite='jessie'
	component='main'
	package='slack-desktop'
	deb-repo
)"

jq <<<"$json" '.' > versions.json
