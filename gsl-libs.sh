#!/bin/bash
set -Eeuo pipefail

: "${dockerfile:=Dockerfile}"
: "${variantAppendOrder:=postfix}" # "postfix" or "prefix" ("tianon/foo:1.2.3-bar" vs "tianon/foo:bar-1.2.3")
declare -a extraCommitFiles

# get the most recent commit which modified any of "$@"
fileCommit() {
	git log -1 --format='format:%H' HEAD -- "$@"
}

# get the most recent commit which modified "$1/Dockerfile" or any file COPY'd from "$1/Dockerfile"
dirCommit() {
	local dir="$1"; shift
	(
		cd "$dir"
		local files
		files="$(git show HEAD:"./$dockerfile" | awk '
			toupper($1) == "COPY" {
				for (i = 2; i < NF; i++) {
					if ($i ~ /^--from=/) {
						next
					}
					print $i
				}
			}
		')"
		fileCommit "$dockerfile" $files "${extraCommitFiles[@]}"
	)
}

# prints "$2$1$3$1...$N"
join() {
	local sep="$1"; shift
	local out; printf -v out "${sep//%/%%}%s" "$@"
	echo "${out#$sep}"
}

globalEntry() {
	cat <<-EOH
		Maintainers: Tianon Gravi <tianon@tianon.xyz> (@tianon)
		GitRepo: https://github.com/${2:-tianon}/${1:-dockerfiles}.git
	EOH
}

tagsEntry() {
	local dir="$1"; shift
	local tags=( "$@" )

	local commit; commit="$(dirCommit "$dir")"

	cat <<-EOE

		Tags: $(join ', ' "${tags[@]}")
		GitCommit: $commit
	EOE
	if [ "$dir" != '.' ]; then
		echo "Directory: $dir"
	fi
	if [ "$dockerfile" != 'Dockerfile' ]; then
		echo "File: $dockerfile"
	fi
}

_versionAliasesHelper() {
	local fullVersion="$1"; shift

	# replace "~" with "-"
	local tilde='~'
	fullVersion="${fullVersion//$tilde/-}"

	# remove any leading "v"
	fullVersion="${fullVersion#v}"

	versionAliases=()
	while [ "${fullVersion%[.-]*}" != "$fullVersion" ]; do
		versionAliases+=( "$fullVersion" )
		fullVersion="${fullVersion%[.-]*}"
	done
	versionAliases+=( "$fullVersion" )
}

versionedTagsEntry() {
	local dir="$1"; shift
	local fullVersion="$1"; shift
	local aliases=( "$@" )

	_versionAliasesHelper "$fullVersion"
	versionAliases+=( "${aliases[@]}" )

	tagsEntry "$dir" "${versionAliases[@]}"
}

_versionEnvHelper() {
	local dir="$1"; shift
	local fullVersionEnv="$1"; shift

	local commit="$(dirCommit "$dir")"
	local fullVersion="$(git -C "$dir" show "$commit":"./$dockerfile" | awk '$1 == "ENV" && $2 == "'"$fullVersionEnv"'" { print $3; exit }')"
	[ -n "$fullVersion" ]

	echo "$fullVersion"
}

versionedEnvTagsEntry() {
	local dir="$1"; shift
	local fullVersionEnv="$1"; shift
	local aliases=( "$@" )

	local fullVersion; fullVersion="$(_versionEnvHelper "$dir" "$fullVersionEnv")"
	[ -n "$fullVersion" ]

	versionedTagsEntry "$dir" "$fullVersion" "${aliases[@]}"
}

# for variants whose version number comes from the variant Dockerfile (openjdk:alpine)
versionedVariantEntry() {
	local dir="$1"; shift
	local variant="$1"; shift
	local fullVersion="$1"; shift
	local aliases=( "$@" )

	_versionAliasesHelper "$fullVersion"

	if [ "$variantAppendOrder" = 'postfix' ]; then
		variantAliases=( "${versionAliases[@]/%/-$variant}" )
	else
		variantAliases=( "${versionAliases[@]/#/$variant-}" )
	fi
	#variantAliases=( "${variantAliases[@]//latest-/}" )
	variantAliases+=( "${aliases[@]}" )

	tagsEntry "$dir" "${variantAliases[@]}"
}

# for variants whose version number comes from the variant Dockerfile (openjdk:alpine)
versionedEnvVariantEntry() {
	local dir="$1"; shift
	local variant="$1"; shift
	local fullVersionEnv="$1"; shift
	local aliases=( "$@" )

	local fullVersion; fullVersion="$(_versionEnvHelper "$dir" "$fullVersionEnv")"
	[ -n "$fullVersion" ]

	versionedVariantEntry "$dir" "$variant" "$fullVersion" "${aliases[@]}"
}
