# given input like a "versions.json", output a json array of relevant "version" fields with paths:
# in: {"foo":{"version":"4.5.6"},"version":"1.2.3"}
# out: ["1.2.3","foo 4.5.6"]
# (see also "update.yml")

[
	path(.. | select(type == "object" and has("version"))) as $path
	| [
		$path[],
		getpath($path).version
	]
]
# TODO perhaps figure out a way to "coalesce" components with the same version number?
| sort_by(length != 1) # make sure "top level" version is first in the list, but everything else in file order (sort_by is stable)
| map(
	# for cases like ["1.6","1.6.X"] or ["1.6.X","1.6.X"], this trims off the excess duplicate
	if length >= 2 and (.[-2] as $lead | .[-1] | . == $lead or startswith($lead)) then
		[ .[0:-2][], .[-1] ]
	else . end
)
| map(join(" "))
