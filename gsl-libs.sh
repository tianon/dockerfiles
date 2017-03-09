#!/bin/bash
set -Eeuo pipefail

# get the most recent commit which modified any of "$@"
fileCommit() {
	git log -1 --format='format:%H' HEAD -- "$@"
}

# get the most recent commit which modified "$1/Dockerfile" or any file COPY'd from "$1/Dockerfile"
dirCommit() {
	local dir="$1"; shift
	(
		cd "$dir"
		fileCommit \
			Dockerfile \
			$(git show HEAD:./Dockerfile | awk '
				toupper($1) == "COPY" {
					for (i = 2; i < NF; i++) {
						print $i
					}
				}
			')
	)
}

# prints "$2$1$3$1...$N"
join() {
	local sep="$1"; shift
	local out; printf -v out "${sep//%/%%}%s" "$@"
	echo "${out#$sep}"
}

globalEntry() {
	cat <<-'EOH'
		Maintainers: Tianon Gravi <tianon@tianon.xyz> (@tianon)
		GitRepo: https://github.com/tianon/dockerfiles.git
	EOH
}

tagsEntry() {
	local dir="$1"; shift
	local tags=( "$@" )

	local commit="$(dirCommit "$dir")"

	cat <<-EOE

		Tags: $(join ', ' "${tags[@]}")
		GitCommit: $commit
		Directory: $dir
	EOE
}

versionedTagsEntry() {
	local dir="$1"; shift
	local fullVersion="$1"; shift
	local aliases=( "$@" )

	local tilde='~'
	fullVersion="${fullVersion//$tilde/-}"

	local versionAliases=()
	while [ "${fullVersion%[.-]*}" != "$fullVersion" ]; do
		versionAliases+=( "$fullVersion" )
		fullVersion="${fullVersion%[.-]*}"
	done
	versionAliases+=( "$fullVersion" "${aliases[@]}" )

	tagsEntry "$dir" "${versionAliases[@]}"
}

versionedEnvTagsEntry() {
	local dir="$1"; shift
	local fullVersionEnv="$1"; shift
	local aliases=( "$@" )

	local commit="$(dirCommit "$dir")"
	local fullVersion="$(git -C "$dir" show "$commit":./Dockerfile  | awk '$1 == "ENV" && $2 == "'"$fullVersionEnv"'" { print $3; exit }')"
	[ -n "$fullVersion" ]

	versionedTagsEntry "$dir" "$fullVersion" "${aliases[@]}"
}
