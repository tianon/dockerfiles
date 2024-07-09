# given a sources.json as output, returns a "fake" builds.json as output

with_entries(
	(.value.arches | keys[]) as $arch
	| .key += "-" + $arch
	| .key as $id
	| .value |= {
		buildId: $id,
		build: {
			img: "localhost:5000/staging:\($id)",
			arch: $arch,
			resolvedParents: (
				.arches[$arch].parents
				| with_entries(
					select(.value.sourceId)
					| .value = {
						annotations: {
							"org.opencontainers.image.ref.name": "localhost:5000/staging:\(.value.sourceId)-\($arch)",
						},
					}
				)
			),
		},
		source: (.arches = { ($arch): .arches[$arch] }),
	}
)
