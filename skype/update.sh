#!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

url="$(curl -sS -D - -o /dev/null 'http://www.skype.com/go/getskype-linux-deb-32' | awk -F ': +|\r' '$1 == "Location" { print $2; exit }')"

set -x
sed -ri 's!^(ENV SKYPE_URL) .*!\1 '"$url"'!' Dockerfile
