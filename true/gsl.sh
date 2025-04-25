#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$BASH_SOURCE")"
dir="$(basename "$PWD")"
cd ..

source gsl-libs.sh

globalEntry
tagsEntry "$dir" latest
dockerfile='Dockerfile.yolo' tagsEntry "$dir" yolo

for variant in oci yoloci; do
	commit="$(fileCommit "$dir/$variant")"
	cat <<-EOE

		Tags: $variant
		GitCommit: $commit
		Directory: $dir/$variant
		Builder: oci-import
		File: index.json
	EOE
done
