See [`Dockerfile`](https://github.com/tianon/dockerfiles/blob/master/syncthing/inotify/Dockerfile) and [example `run.sh` script](https://github.com/tianon/dockerfiles/blob/master/syncthing/inotify/run.sh) for usage.

This image is only useful in the context of a running instance of `syncthing`, so check out [`tianon/syncthing`](https://registry.hub.docker.com/u/tianon/syncthing/) if you don't have `syncthing` already.

You probably also want to read ["Troubleshooting for folders with many files on Linux"](https://github.com/syncthing/syncthing-inotify#troubleshooting-for-folders-with-many-files-on-linux), especially `sudo sysctl -w fs.inotify.max_user_watches=204800` (as the temporary not-safe-from-reboot solution).
