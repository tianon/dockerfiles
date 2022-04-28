Ever wanted to speedtest a server, but didn't want to do funky tunnelling so you could hit up good ol' speedtest.net?  WORRY NO MORE.

    docker run -it --rm --net=host tianon/speedtest

We don't actually _require_ `--net=host`, but if we're wanting to test native performance (or use `--ip some-specific-host-IP` / `--interface some-specific-host-interface`) then we want direct access to the relevant connections without any overhead.
