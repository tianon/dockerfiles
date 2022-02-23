#!/usr/bin/env bash
set -Eeuo pipefail

sha512="$(wget -qO- 'https://cygwin.com/sha512.sum' | awk -v ret=1 '$2 == "setup-x86_64.exe" { print $1; ret = 0; exit ret } END { exit ret }')"

sed -ri -e 's/^(ENV CYGWIN_SETUP_SHA512) .*/\1 '"$sha512"'/' Dockerfile

versions=(
	# https://hub.docker.com/r/microsoft/windowsservercore
	ltsc2022
	20H2
	1809

	# EOL
	#1709
	#1803
	#1903
	#1909
	#2004

	# ltsc2016...  too big/slow to bother anymore
	#1607
)

for version in "${versions[@]}"; do
	sed -re 's!^(FROM) .*!\1 mcr.microsoft.com/windows/servercore:'"$version"'!' Dockerfile > "Dockerfile.$version"
done
