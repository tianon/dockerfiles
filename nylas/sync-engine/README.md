# Nylas Sync Engine

## MySQL

```bash
mkdir -p "$HOME/temp/nylas-sync-mysql"
docker run -dit \
	--restart always \
	--name nylas-sync-mysql \
	-v "$HOME/temp/nylas-sync-mysql":/var/lib/mysql \
	-e MYSQL_ROOT_PASSWORD=inboxapp \
	mysql:5.6
```

## Redis

```bash
docker run -dit \
	--restart always \
	--name nylas-sync-redis \
	redis
```

## Sync API

```bash
docker run -dit \
	--restart always \
	--name nylas-sync-api \
	--link nylas-sync-mysql:mysql \
	--expose 5555 \
	tianon/nylas-sync-engine \
	inbox-api
```

## Sync Engine

```bash
docker run -dit \
	--restart always \
	--name nylas-sync-engine \
	--link nylas-sync-mysql:mysql \
	--link nylas-sync-redis:redis \
	--expose 16384 \
	tianon/nylas-sync-engine \
	inbox-start
```

## Auth

```console
$ docker run -it --rm \
	--link nylas-sync-mysql:mysql \
	tianon/nylas-sync-engine \
	inbox-auth jsmith@gmail.com
```
