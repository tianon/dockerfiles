#!/bin/bash
set -e

current="$(curl -fsSL 'https://rubygems.org/api/v1/gems/travis.json' | jq -r '.version')"

set -x
sed -ri 's/^(ENV TRAVIS_CLI_VERSION) .*/\1 '"$current"'/' Dockerfile
