#!/usr/bin/env bash
set -Eeuo pipefail

git-tags() {
	local repo="$1"; shift
	[ -n "$repo" ]

	local tag
	# prometheus had "2.35.0-retract" 😩
	tag="$(
		git ls-remote --tags "$repo" \
			| cut -d/ -f3 \
			| cut -d^ -f1 \
			| grep -vE -- '-(rc|alpha|beta|retract)|^nightly$' \
			| sort -Vu \
			| tail -1
	)"
	local version="${tag#v}"

	local base; base="$(basename "$repo")"
	echo >&2 "git $base: $version"

	jq -nc --arg tag "$tag" --arg version "$version" '
		{
			version: $version,
			tag: $tag,
		}
	'
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
	atom="$(wget -qO- "https://github.com/$repo/commits/$branch/$file.atom")"
	local commit
	commit="$(awk <<<"$atom" -F ' *[<>/]+' '$2 == "id" && $3 ~ /Commit/ { print $4; exit }')"

	echo >&2 "github $repo - $file: $commit"

	jq -nc --arg commit "$commit" '{ version: $commit }'
}
