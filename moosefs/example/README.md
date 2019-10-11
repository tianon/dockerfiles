```console
$ docker swarm init # (or "docker swarm join ...")

$ sudo ./prep-host.sh # on every host
$ docker stack deploy -c stack.yml mfs

$ # run once per drive you want to dedicate to MooseFS
$ # THIS WILL WIPE YOUR DRIVE, SO USE CAREFULLY
$ sudo ./prep-chunk-drive.sh /dev/XXX

# TODO make this run at system boot? something something
# (perhaps our "mfs-pause" container could actually do this when it starts up!)
$ sudo ./mount-chunk-drives.sh

$ sudo ./start-chunk-servers.sh
$ sudo ./start-client.sh

$ mountpoint /mnt/mfs/fs
/mnt/mfs/fs is a mountpoint

$ # ready to use!

$ # optional:
$ sudo ln -sT "$PWD/cli.sh" /usr/local/bin/mfscli
$ sudo ln -sT "$PWD/tools.sh" /usr/local/bin/mfstools
$ # TODO make these smart with "$0" (since they are 99% identical as-is), would also allow more clever mfstools usage like symlinks to mfsgetgoal etc directly
```
