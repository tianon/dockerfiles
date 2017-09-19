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
	cat <<-EOH
		Maintainers: Tianon Gravi <tianon@tianon.xyz> (@tianon)
		GitRepo: https://github.com/${2:-tianon}/${1:-dockerfiles}.git
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
	local fullVersion="$(git -C "$dir" show "$commit":./Dockerfile  | awk '$1 == "ENV" && $2 == "'"$fullVersionEnv"'" { print $3; exit }')"
	[ -n "$fullVersion" ]

	echo "$fullVersion"
}

versionedEnvTagsEntry() {
	local dir="$1"; shift
	local fullVersionEnv="$1"; shift
	local aliases=( "$@" )

	local fullVersion="$(_versionEnvHelper "$dir" "$fullVersionEnv")"
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
	variantAliases=( "${versionAliases[@]/%/-$variant}" )
	#variantAliases=( "${variantAliases[@]//latest-/}" )
	variantAliases+=( "${aliases[@]}" )

	tagsEntry "$dir" "${variantAliases[@]}"
}

# for variants whose version number comes from the parent Dockerfile (tianon/dell-netextender:gui)
versionedSubvariantEntry() {
	local dir="$1"; shift
	local fullVersion="$1"; shift
	local variant="$1"; shift
	local aliases=( "$@" )

	versionedVariantEntry "$dir/$variant" "$variant" "$fullVersion" "${aliases[@]}"
}

# for variants whose version number comes from the variant Dockerfile (openjdk:alpine)
versionedEnvVariantEntry() {
	local dir="$1"; shift
	local variant="$1"; shift
	local fullVersionEnv="$1"; shift
	local aliases=( "$@" )

	local fullVersion="$(_versionEnvHelper "$dir" "$fullVersionEnv")"
	[ -n "$fullVersion" ]

	versionedVariantEntry "$dir" "$variant" "$fullVersion" "${aliases[@]}"
}

# for variants whose version number comes from the parent Dockerfile (tianon/dell-netextender:gui)
versionedEnvSubvariantEntry() {
	local dir="$1"; shift
	local fullVersionEnv="$1"; shift
	local variant="$1"; shift
	local aliases=( "$@" )

	local fullVersion="$(_versionEnvHelper "$dir" "$fullVersionEnv")"
	[ -n "$fullVersion" ]

	versionedSubvariantEntry "$dir" "$fullVersion" "$variant" "${aliases[@]}"
}
