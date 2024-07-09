#
# IMPORTANT: this relies on builds.json (and thus sources.json) being pre-topsorted -- if builds.json is not in topsort order already, this will not function/group correctly
#

# when run on a "builds.json", this will output an array of arrays of "grouped" build objects (parent/child)

# turn object into (positional) array
[ .[] ]
# save current positions so we can use them for re-sorting our groups later
| (with_entries({ key: .value.buildId, value: .key })) as $sort

# work backwards through the list, combining things above things we already parsed
| reduce reverse[] as $b ([];
	(
		first(
			.[]
			| select(any(
				.build.arch == $b.build.arch and (
					[ .source.arches[.build.arch].parents[].sourceId // empty ]
					| index($b.source.sourceId) or index($b.source.arches[$b.build.arch].parents[].sourceId // empty)
				)
			))
		)
		// .[length]
	) |= [ $b ] + .
)

# put our groups back roughly in the original order (based on the "lowest position" buildId inside each group)
| sort_by([ $sort[.[].buildId] ] | min)
