# containerd

```console
$ docker run -dit --name containerd --user nobody tianon/containerd
$ docker exec -it containerd bash
nobody@828358e6a99a:/$ ctr content fetch --all-platforms docker.io/foo/bar:baz
...
nobody@828358e6a99a:/$ ctr images push --user jsmith docker.io/baz/bar:foo docker.io/foo/bar:baz
...
```
