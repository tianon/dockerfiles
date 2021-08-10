#!/usr/bin/env bash
set -Eeuo pipefail

suite="$(gawk -F '[[:space:]:]+' '$1 == "FROM" { print $3; exit }' Dockerfile)"

version="$(
	# https://launchpad.net/~stebbins/+archive/ubuntu/handbrake-releases
	wget -qO- "http://ppa.launchpad.net/stebbins/handbrake-releases/ubuntu/dists/$suite/main/binary-amd64/Packages.xz" \
		| xz -d \
		| tac|tac \
		| gawk -F ':[[:space:]]+' '
			$1 == "Package" { pkg = $2 }
			$1 == "Version" {
				if (pkg == "handbrake-cli") {
					cli = $2
					next
				}
				if (pkg == "handbrake-gtk") {
					gtk = $2
					next
				}
			}
			END {
				if (cli && cli == gtk) {
					print cli
					exit 0
				} else {
					printf "error: version missing/mismatch!\n\t\"%s\" vs \"%s\" (cli vs gtk)\n", cli, gtk > "/dev/stderr"
					exit 1
				}
			}
		'
)"
cleanVersion="${version##*:}"
cleanVersion="${cleanVersion%%-*}"

echo "handbrake: $cleanVersion ($version)"

sed -ri \
	-e 's!^(ENV HANDBRAKE_VERSION) .*!\1 '"$cleanVersion"'!' \
	-e 's!^(ENV HANDBRAKE_PPA_VERSION) .*!\1 '"$version"'!' \
	Dockerfile
