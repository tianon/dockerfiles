# beets

[beets.radbox.org](http://beets.radbox.org/)

```console
$ mkdir -p "$HOME/.config/beets"
$ docker run -it --rm \
	-u "$(id -u):$(id -g)" \
	-v "$PWD:/cwd" \
	-w /cwd \
	-v "$HOME/.config/beets:$HOME/.config/beets" \
	-e HOME \
	tianon/beets \
	beet <subcommand>
```
