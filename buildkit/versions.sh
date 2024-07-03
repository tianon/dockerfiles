#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../.libs/git.sh"

variants=(
	''
	'rc'

	'0.13'

	# TODO add this back when I figure out a clean way to do something more akin to a "weekly snapshot" or something so it doesn't have an update every single day
	#'dev'
)

json='{}'

for variant in "${variants[@]}"; do
	export variant

	bk=
	case "$variant" in
		'')
			bk="$(
				versions_hooks+=( hook_no-prereleases )
				git-tags 'https://github.com/moby/buildkit.git'
			)"
			;;

		rc)
			bk="$(
				hook_prereleases-only() { ! hook_no-prereleases "$@"; }
				versions_hooks+=( hook_prereleases-only )
				git-tags 'https://github.com/moby/buildkit.git'
			)"
			;;

		[0-9]*.[0-9]*)
			bk="$(
				hook_variant-version() {
					case "$3" in "$variant" | "$variant".*) return 0 ;; esac
					return 1
				}
				versions_hooks+=( hook_no-prereleases hook_variant-version )
				git-tags 'https://github.com/moby/buildkit.git'
			)"
			;;

		dev)
			bk="$(git-ref-commit 'https://github.com/moby/buildkit.git' 'HEAD')"
			;;

		*) echo >&2 "error: unknown variant: '$variant'"; exit 1 ;;
	esac
	[ -n "$bk" ]

	commit="$(jq <<<"$bk" -r '.commit // .version')"
	go="$(wget -qO- "https://github.com/moby/buildkit/raw/$commit/go.mod")"
	go="$(awk <<<"$go" '$1 == "go" { if ($2 ~ /^[0-9]+[.][0-9]+[.][0-9]+$/) { sub(/[.][0-9]+$/, "", $2) } print $2; exit }')"
	echo >&2 "${variant:-stable} go: $go"

	json="$(jq <<<"$json" --argjson bk "$bk" --arg go "$go" '
		if env.variant == "" then . else .[env.variant] end += $bk + { go: { version: $go } }
		| .variants += [ env.variant ]
	')"
done

jq <<<"$json" '.' > versions.json
