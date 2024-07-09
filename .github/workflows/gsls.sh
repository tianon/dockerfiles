#!/usr/bin/env bash
set -Eeuo pipefail

[ -d "$BASHBREW_LIBRARY" ]

for gsl in */gsl.sh; do
	dir="$(dirname "$gsl")"
	img="$(basename "$dir")"
	echo "$img"
	"$gsl" > "$BASHBREW_LIBRARY/$img"
	if false; then # TODO make sure this stuff is accurately represented in the new world
	case "$img" in
		'tianon/infosiftr-moby')
			# remove per-architecture tags for now (temporary workaround for https://github.com/docker-library/bashbrew/pull/81)
			newStrategy="$(jq -c 'del(.matrix.include[] | select(.meta.entries[].tags | contains(["tianon/infosiftr-moby:latest"]) | not))' <<<"$newStrategy")"
			;;

		'tianon/cygwin')
			# remove tags that Windows on GitHub Actions can't test
			newStrategy="$(jq -c 'del(.matrix.include[] | select(.os == "invalid-or-unknown"))' <<<"$newStrategy")"
			;;

		'tianon/true')
			# make sure our "true" binaries are correctly compiled
			newStrategy="$(jq -c '
				.matrix.include[].runs.build |= (
					(if contains("yolo") then "true-yolo" else "true-asm" end) as $binary
					| [
						"[ -s true/\($binary) ]",
						"rm -v true/\($binary)",
						"docker build --pull --tag tianon/true:builder --target asm --file true/Dockerfile.all true",
						"docker run --rm tianon/true:builder tar -cC /true \($binary) | tar -xvC true",
						"git diff --exit-code true",
						"[ -s true/\($binary) ]",
						"true/\($binary)",
						.
					] | join("\n")
				)
			' <<<"$newStrategy")"
			;;
	esac
	fi
done

if false; then # TODO figure out a clean way to account for "dangling" Dockerfiles in the new world
# now that we have a list of legit images with generate scripts, look for dangling Dockerfiles
allDockerfiles="$(git ls-files '*/Dockerfile' | jq -Rsc 'rtrimstr("\n") | split("\n")')"
danglingDockerfiles="$(jq <<<"$strategy" -c --argjson allDockerfiles "$allDockerfiles" '$allDockerfiles - [ .matrix.include[].meta.dockerfiles[] ]')"

# TODO this could probably be implemented via some crafted "GENERATE_STACKBREW_LIBRARY" expressions that output a fake GSL file 🤔
strategy="$(jq -c --argjson danglingDockerfiles "$danglingDockerfiles" '.matrix.include[0] as $first | .matrix.include += [
	$danglingDockerfiles[]
	| sub("/Dockerfile$"; "") as $dir
	| (env.BASHBREW_NAMESPACE + "/" + ($dir | sub("/"; ":") | gsub("/"; "-"))) as $img
	| {
			name: ("DANGLING: " + . + " (" + $img + ")"),
			os: "ubuntu-latest",
			runs: {
				prepare: $first.runs.prepare,
				build: ("DOCKER_BUILDKIT=0 docker build -t " + ($img | @sh) + " " + ($dir | @sh)),
				history: ("docker history " + ($img | @sh)),
				test: ("~/oi/test/run.sh --config ~/oi/test/config.sh --config .test/config.sh " + ($img | @sh)),
				images: $first.runs.images,
			},
	}
]' <<<"$strategy")"
fi
