#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../.libs/deb-repo.sh"

json='{ "variants": [] }'
for variant in weekly lts; do
	uri='https://pkg.jenkins.io/debian'
	if [ "$variant" = 'lts' ]; then
		uri+='-stable'
	fi
	vjson="$(
		suite='binary/'
		package='jenkins'
		deb-repo
	)"
	json="$(jq <<<"$json" -c --arg variant "$variant" --arg repo "$uri" --argjson vjson "$vjson" '
		.[$variant] = $vjson + { repo: $repo }
		| .variants += [ $variant ]
	')"
done

jq <<<"$json" '.' > versions.json
