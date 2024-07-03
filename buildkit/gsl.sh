#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$BASH_SOURCE")"
dir="$(basename "$PWD")"
cd ..

# TODO from="$(awk '$1 == "FROM" { from = $3 } END { print from }' "$dir/Dockerfile")" # TODO multi-stage build more intelligently 😬
from='infosiftr/moby'
arches="$(bashbrew remote arches --json "$from" | jq -r '.arches | keys | join(", ")')"

commit="$(git -C "$dir" log -1 --format='format:%H' HEAD -- .)"

export arches commit dir
exec jq -r '
	[
		{
			Maintainers: "Tianon Gravi <tianon@tianon.xyz> (@tianon)",
			GitRepo: "https://github.com/tianon/dockerfiles.git",
			GitCommit: env.commit,
			Directory: env.dir,
			Architectures: env.arches,
			Builder: "buildkit",
		},
		(
			(
				[
					.variants[] as $variant
					| {
						key: $variant,
						value: (
							if $variant == "" then
								.version
							else
								.[$variant].version
							end
						),
					}
				]
				| from_entries
			)
			| if (.rc | split(".-") | tonumber? // .) <= (.[""] | split(".-") | tonumber? // .) then
				# if the RC is not newer than the current stable, skip it
				del(.rc)
			else . end
			| with_entries(
				.key as $variant
				| .value as $version
				| .value = (
					if $variant == "dev" then
						[]
					else
						$version
						| [ scan("(?:[.-]+|^)[^.-]*") ]
						| reduce .[] as $p ([];
							if length > 0 then
								[ .[0] + $p, .[] ]
							else [ $p ] end
						)
					end
					| . + [
						if $variant == "" then
							"latest"
						elif index($variant) | not then
							$variant
						else empty end
					]
				)
			)
			| reduce to_entries[] as $e ({};
				.[$e.key] = $e.value - [ .[][] ]
			)
			| to_entries[]
			| .key as $variant
			| .value
			| {
				Tags: join(", "),
				File: ("Dockerfile" + if $variant != "" then "." + $variant else "" end),
			}
		)
	]
	| .[0].File as $globalFile
	| map(
		if .File == "Dockerfile" and ($globalFile | not) then
			del(.File)
		else . end
		| to_entries
		| map(.key + ": " + .value)
		| join("\n")
	)
	| join("\n\n")
' "$dir/versions.json"
