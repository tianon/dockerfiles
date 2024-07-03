#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$BASH_SOURCE")"
dir="$(basename "$PWD")"
cd ..

from="$(awk '$1 == "FROM" { print $2; exit }' "$dir/Dockerfile")" # TODO multi-stage build??
fromArches="$(bashbrew remote arches --json "$from" | jq -r '.arches | keys')"

commit="$(git -C "$dir" log -1 --format='format:%H' HEAD -- .)"

export fromArches commit dir
exec jq -r -L "$dir/../.libs" '
	include "lib"
	;
	(env.fromArches | fromjson) as $fromArches
	| (
		[
			$fromArches,
			(.runc.arches | map_values(select(.dpkgArch)) | keys),
			empty
		]
		| intersection
	) as $intArches
	| [
		{
			Maintainers: "Tianon Gravi <tianon@tianon.xyz> (@tianon)",
			GitRepo: "https://github.com/tianon/dockerfiles.git",
			GitCommit: env.commit,
			Directory: env.dir,
		},
		(
			(
				[
					.variants[] as $variant
					| {
						key: $variant,
						value: (
							if $variant != "" then .[$variant] else . end
							| {
								variant: $variant,
								version: .version,
								arches: (
									[
										$intArches,
										(.arches | map_values(select(.dpkgArch)) | keys),
										empty
									]
									| intersection
								),
							}
						),
					}
				]
				| from_entries
			)
			| if (.rc.version | split(".-") | tonumber? // .) <= (.[""].version | split(".-") | tonumber? // .) then
				# if the RC is not newer than the current stable, skip it
				del(.rc)
			else . end
			| map(
				.variant as $variant
				| {
					Tags: (
						.version as $version
						| if $variant == "dev" then
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
						| if $version | startswith("1.7.") then
							# backwards compatible "c8dind" tags for 1.7
							. += map(
								. + "-c8dind"
								| sub("^latest-"; "")
							)
						else . end
					),
					Architectures: (.arches | join(", ")),
					File: ("Dockerfile" + if $variant != "" then "." + $variant else "" end),
				}
			)
			| reduce .[] as $e ([];
				[ .[].Tags[] ] as $tags
				| . += [ $e | .Tags -= $tags ]
			)
			| .[]
			| .Tags |= join(", ")
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
