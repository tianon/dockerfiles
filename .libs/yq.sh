#!/usr/bin/env bash
set -Eeuo pipefail

yqDir="$(dirname "$BASH_SOURCE")"
yq="$yqDir/.yq"

# https://github.com/mikefarah/yq/releases
# TODO detect host architecture
yqUrl='https://github.com/mikefarah/yq/releases/download/v4.47.1/yq_linux_amd64'
yqSha256='0fb28c6680193c41b364193d0c0fc4a03177aecde51cfc04d506b1517158c2fb'
if command -v yq &> /dev/null; then
	# TODO verify that the "yq" in PATH is https://github.com/mikefarah/yq, not the python-based version you'd get from "apt-get install yq" somehow?  maybe they're compatible enough for our needs that it doesn't matter?
	yq='yq'
elif [ ! -x "$yq" ] || ! sha256sum <<<"$yqSha256 *$yq" --quiet --strict --check; then
	wget -qO "$yq.new" "$yqUrl"
	sha256sum <<<"$yqSha256 *$yq.new" --quiet --strict --check
	chmod +x "$yq.new"
	"$yq.new" --version
	mv "$yq.new" "$yq"
fi
