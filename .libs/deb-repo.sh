#!/usr/bin/env bash
set -Eeuo pipefail

# TODO implement "hooks.sh"

deb-repo() {
	[ -n "$uri" ]
	[ -n "$suite" ]
	#[ -n "$component" ] # if suite ends with /, this is optional
	: "${arch:=amd64}"
	[ -n "$package" ]

	_deb-repo_packages() {
		local packages
		if [[ "$suite" == */ ]]; then
			[ -z "${component:-}" ]
			packages="$uri/${suite}Packages"
		else
			[ -n "$component" ]
			packages="$uri/dists/$suite/$component/binary-$arch/Packages"
		fi
		{ wget -qO- "$packages.xz" | xz -d 2>/dev/null; } \
		|| { wget -qO- "$packages.bz2" | bunzip2 2>/dev/null; } \
		|| { wget -qO- "$packages.gz" | gunzip 2>/dev/null; } \
		|| { wget -qO- "$packages.zstd" | zstd -d 2>/dev/null; } \
		|| wget -qO- "$packages"
	}

	local versions version
	versions="$(
		_deb-repo_packages | gawk -F ':[[:space:]]+' -v package="$package" '
			function do_the_thing() { if (pkg == package) { printf "%s %s\n", ver, sha256 }; pkg = ver = sha256 = "" }
			$1 == "Package" { do_the_thing(); pkg = $2; ver = sha256 = "" }
			$1 == "Version" { ver = $2 }
			$1 == "SHA256" { sha256 = $2 }
			END { do_the_thing() }
		' | sort -rV
	)"
	version="$(head -1 <<<"$versions")" # TODO some way to get *not* the latest version?
	if [ -z "$version" ]; then
		echo >&2 "error: failed to find a version for '$package' in '$uri' (suite '$suite'${component:+, comp '$component'}, arch '$arch')"
		return 1
	fi
	local sha256="${version##* }"
	version="${version% $sha256}"
	[ "$sha256" != "$version" ] || sha256=

	echo >&2 "deb $package: $version"
	# TODO gather "supported arches" list

	jq -nS --arg version "$version" --arg sha256 "$sha256" '
		{
			version: $version,
		} | if $sha256 then .sha256 = $sha256 else . end
	'
}
