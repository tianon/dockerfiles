#!/bin/bash
set -e

# if we have d/watch, let's try uscan, since it's superfast and rules
if [ -e debian/watch ]; then
	# TODO bah! uscan uses exit code 0 even when it fails to download
	if uscan --force-download --verbose --download-current-version; then
		exit 0
	fi
fi

# failing uscan, let's check to see if there's a "generate-tarball" helper
if [ -x debian/helpers/generate-tarball.sh ]; then
	if ./debian/helpers/generate-tarball.sh ..; then
		exit 0
	fi
fi

# failing that, let's walk backwards in d/changelog with "apt-get source"
if [ -e debian/changelog ]; then
	IFS=$'\n'
	versions=( $(awk '/^\S/ { print $1"="substr($2, 2, length($2)-2) }' debian/changelog) )
	unset IFS
	
	for version in "${versions[@]}"; do
		if ( cd .. && apt-get source --download-only "$version" ); then
			exit 0
		fi
	done
fi
