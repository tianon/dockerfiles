#
# this expects the output of "group-builds.jq" as input
# output is something suitable for a GHA "strategy" field (see "ci.yml")
#

include "meta"; # this comes from "meta-scripts" ("jq -L .meta-scripts ...")

map(
	.[0].build.arch as $arch
	| if any(.build.arch != $arch) then error("arch mismatch!\n" + tojson) else . end
	| {
		name: "\(map(first(.source.arches[$arch] | .tags[], .archTags[])) | join(", ")) [\($arch)]",
		runsOn: (
			# https://github.com/actions/runner-images#available-images
			if $arch == "windows-amd64" then
				"windows-" + (
					.[0].source.arches[$arch].froms
					| if contains(["ltsc2022"]) then
						"2022"
					elif contains(["1809"]) then
						"2019"
					else "unknown" end
				)
			else "ubuntu-22.04" end # TODO add support for ubuntu-24.04 to tianon/debian-moby-action
		),
		commands: (
			map(
				first(.source.arches[$arch] | .tags[], .archTags[]) as $name
				| [
					"(",
					"echo \("::group::prep \($name)" | @sh)",
					"set -x",
					"mkdir \(.buildId | @sh)",
					"cd \(.buildId | @sh)",
					"set +x",
					"echo \("::endgroup::" | @sh)",
					"echo \("::group::pull \($name)" | @sh)",
					"( set -x", pull_command, ")",
					"echo \("::endgroup::" | @sh)",
					"echo \("::group::build \($name)" | @sh)",
					"( set -x", build_command, ")",
					"echo \("::endgroup::" | @sh)",
					# TODO only push if we have more than one image we're going to build? (on the one hand it's useful to exercise the push code, but on the other, it's a waste of time that *also* tends to confuse consumers who think this is doing the real push to Docker Hub...)
					# TODO run tests -- counter to the above point, our "build_command" does *not* guarantee the image is in the local image store (and "docker load" doesn't even support OCI layout tarballs until like 27+), so pulling it back down from the registry might be the only way we can officially run the tests?  unless we change meta-scripts so that it *does* promise the image is loaded into the local image store 😞
					"echo \("::group::push (NOT PRODUCTION) \($name)" | @sh)",
					"( set -x", push_command, ")",
					"echo \("::endgroup::" | @sh)",
					")",
					empty
				]
				| join("\n")
			)
			| [ "set +x" ] + .
			| join("\n\n")
		),
		builds: .,
	}
)
| {
	matrix: { include: . },
	"fail-fast": false,
}
