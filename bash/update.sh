#!/bin/bash
set -euo pipefail

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

versions=( "$@" )
if [ ${#versions[@]} -eq 0 ]; then
	versions=( */ )
fi
versions=( "${versions[@]%/}" )

ftpBase='ftp://ftp.gnu.org/gnu/bash'
allBase="$(curl --silent --list-only "$ftpBase/")"

travisEnv=
for version in "${versions[@]}"; do
	bashVersion="$version"

	IFS=$'\n'
	allVersions=( $(
		echo "$allBase" \
			| grep '^bash-'"$bashVersion"'.*\.tar\.gz$' \
			| sed -r 's/^bash-|\.tar\.gz$//g' \
			| grep -vE -- '-(rc|beta)' \
			| sort -rV
	) )
	allPatches=( $(
		curl --silent --list-only "$ftpBase/bash-$bashVersion-patches/" \
			| grep -E '^bash'"${bashVersion//./}"'-[0-9]{3}$' \
			| sed -r 's/^bash'"${bashVersion//./}"'-0*//g' \
			| sort -rn \
		|| true
	) )
	unset IFS

	if [ "${#allVersions[@]}" -eq 0 ]; then
		echo >&2 "error: cannot find any releases of $version in $ftpBase"
		exit 1
	fi
	latestVersion="${allVersions[0]}"

	latestPatch='0'
	if [ "${#allPatches[@]}" -gt 0 ]; then
		latestPatch="${allPatches[0]}"
	fi

	patchLevel='0'
	if [[ "$latestVersion" == *.*.* ]]; then
		patchLevel="${latestVersion##*.*.}"
	fi

	(
		set -x
		sed -ri '
			s/^(ENV _BASH_VERSION) .*/\1 '"$bashVersion"'/;
			s/^(ENV _BASH_PATCH_LEVEL) .*/\1 '"$patchLevel"'/;
			s/^(ENV _BASH_LATEST_PATCH) .*/\1 '"$latestPatch"'/
		' "$version/Dockerfile"
	)
	travisEnv='\n  - VERSION='"$version$travisEnv"
done

travis="$(awk -v 'RS=\n\n' '$1 == "env:" { $0 = "env:'"$travisEnv"'" } { printf "%s%s", $0, RS }' .travis.yml)"
echo "$travis" > .travis.yml
