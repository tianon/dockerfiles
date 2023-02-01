#!/usr/bin/env bash
set -Eeuo pipefail

image="$1"

docker run --rm "$image"
