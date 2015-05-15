# beets

[beets.radbox.org](http://beets.radbox.org/)

```console
$ docker run -it --rm \
	-u "$(id -u):$(id -g)" \
	-v "$PWD:/cwd" \
	-w /cwd \
	tianon/beets \
	beet <subcommand>
```
