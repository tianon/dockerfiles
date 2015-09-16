# phpMyAdmin

```console
$ docker run -d --name phpmyadmin --link some-mysql:mysql tianon/phpmyadmin
```

Hit `http://phpmyadmin.docker` in your browser (because [you're using `rawdns`, right??](https://hub.docker.com/r/tianon/rawdns/)).
