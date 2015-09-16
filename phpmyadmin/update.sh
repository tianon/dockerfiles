#!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

latest="$(curl -fsSL 'https://www.phpmyadmin.net/home_page/version.json' | awk -F ' +"|": "|",' '$2 == "version" { print $3; exit }')"

set -x
sed -ri 's!^(ENV PHPMYADMIN_VERSION).*!\1 '"$latest"'!' Dockerfile
