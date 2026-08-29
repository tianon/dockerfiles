#!/usr/bin/env bash
set -Eeuo pipefail

_libsDir="$(dirname "$BASH_SOURCE")"
source "$_libsDir/hooks.sh"
unset _libsDir

git-tags() {
	local repo="$1"; shift
	[ -n "$repo" ]

	local reponame="${repo%.git}"
	reponame="${reponame#git://}"
	reponame="${reponame#http://}"
	reponame="${reponame#https://}"

	local tags
	tags="$(git ls-remote --tags --sort=-version:refname "$repo")" || return "$?"

	local json
	json="$(jq <<<"$tags" -sR '
		rtrimstr("\n")
		| split("\n")
		| map(
			capture("^(?<commit>[a-f0-9]+)\t(?<ref>refs/tags/(?<tag>v(?<version>[0-9]+.*?)|.*?)(?:\\^{})?)$")
			| .version //= .tag
		)
		# (ab)using that "git ls-remote --sort=-version:refname" will list the objects "annotated" tags point to before the annotated counterparts, so they will be the ref we return here (ie, we return the "real" commit ID, not the reference to the annotated tag object)
		| reduce .[] as $i ({}; .[$i.version] //= $i)
		| [ .[] ]
	')" || return "$?"

	local jsons
	jsons="$(jq <<<"$json" -r 'map(tojson | @sh) | join(" ")')" || return "$?"
	eval "jsons=( $jsons )"

	(
		versions_loop_setvars() {
			json="$1"
			version="$(jq <<<"$json" -r '.version')" || return "$?"
		}
		versions_loop 'git' "$reponame" "${jsons[@]}"
	)
}

git-ref-commit() {
	local repo="$1"; shift
	local ref="$1"; shift

	local commit
	commit="$(git ls-remote "$repo" "$ref" | cut -d$'\t' -f1)"

	local base; base="$(basename "$repo")"
	echo >&2 "git $base - $ref: $commit"

	jq -nc --arg commit "$commit" '{ version: $commit }'
}

github-file-commit() {
	local repo="$1"; shift
	local branch="$1"; shift
	local file="$1"; shift
	[ -n "$repo" ]
	[ -n "$branch" ]
	[ -n "$file" ]

	local atom
	atom="$(wget -qO- --header 'Accept: application/json' "https://github.com/$repo/commits/$branch/$file.atom")"
	local shell
	shell="$(jq <<<"$atom" -r '
		first(.payload.commitGroups[].commits[])
		| @sh "local commit=\(.oid) date=\(first([ .committedDate, .authoredDate ] | sort | reverse[]))"
	')"
	eval "$shell"
	[ -n "$commit" ] || return 1 # TODO error message?
	[ -n "$date" ] || return 1
	local unix
	unix="$(date --utc --date "$date" '+%s')" || return 1 # TODO error message?

	echo >&2 "github $repo - $file: $commit ($date -- @$unix)"

	jq -nc --arg commit "$commit" --arg date "$date" --arg unix "$unix" '{
		version: $commit,
		$date,
		unix: ($unix | tonumber),
	}'
}

github-clamp-commit() {
	local repo="$1" # "containerd/containerd"
	local date="${2:-last monday 00:00:00}" # something date(1) can parse
	local ref="${3:-HEAD}" # ref to start walking backwards from

	local clampUnix
	clampUnix="$(date --utc --date "$date" '+%s')" || return 1

	local commit= date unix
	while [ -z "$commit" ]; do
		local commits
		commits="$(
			wget -qO- --header 'Accept: application/json' "https://github.com/$repo/commits/$ref.atom" \
				| jq -r '
					.payload.commitGroups[].commits[]
					| first([ .committedDate, .authoredDate ] | sort | reverse[]) as $date
					| "\(.oid) \($date)"
					| @sh
				'
		)"
		eval "local commitDates=( $commits ) commitDate"
		[ "${#commitDates[@]}" -gt 0 ] || return 1 # TODO error message?
		for commitDate in "${commitDates[@]}"; do
			ref="${commitDate%%[[:space:]]*}"
			date="${commitDate#$ref[[:space:]]}"
			[ "$ref" != "$date" ] || return 1 # TODO error message?
			unix="$(date --utc --date "$date" '+%s')" || return 1 # TODO error message?
			if [ "$unix" -le "$clampUnix" ]; then
				commit="$ref"
				break 2
			fi
		done
	done
	[ -n "$commit" ] || return 1 # TODO error message?
	[ -n "$date" ] || return 1
	[ -n "$unix" ] || return 1

	echo >&2 "github $repo: $commit ($date -- @$unix)"

	jq -nc --arg commit "$commit" --arg date "$date" --arg unix "$unix" '{
		version: $commit,
		$date,
		unix: ($unix | tonumber),
	}'
}
