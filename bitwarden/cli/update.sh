#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$BASH_SOURCE")"

current="$(wget -qO- 'https://registry.npmjs.org/@bitwarden/cli' | jq -r '."dist-tags".latest')"

echo "bitwarden-cli: $current"

sed -ri -e 's/^(ENV BITWARDEN_VERSION) .*/\1 '"$current"'/' Dockerfile
