```console
$ docker run -it --name remote-net --cap-add NET_ADMIN --device /dev/ppp tianon/dell-netextender
...
```

More complex example:

```console
$ docker run -it --name remote-net --cap-add NET_ADMIN --device /dev/ppp tianon/dell-netextender netExtender --username=me --password=my-pass --domain=remote-domain remote-ip:5533
...

$ docker run -it --rm --network container:remote-net buildpack-deps:stretch-scm
root@b86fe5681726:/# ssh ip-from-netextender-vpn-network
```
