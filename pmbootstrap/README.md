```console
$ mkdir "$HOME/some-pmbootstrap-path"
$ docker run -it --rm \
	--mount type=bind,src="$HOME/some-pmbootstrap-path",dst=/work,bind-propagation=rslave \
	--workdir /work \
	--env HOME=/work \
	--user "$(id -u):$(id -g)" \
	--group-add wheel \
	--mount type=bind,src=/etc/passwd,dst=/etc/passwd,ro \
	--device-cgroup-rule 'a 8:* rwm' \
	--mount type=bind,src=/dev,dst=/hostdev,ro,bind-propagation=rslave \
	--cap-add SYS_ADMIN \
	--security-opt apparmor=unconfined \
	tianon/pmbootstrap
/work $ pmbootstrap init
/work $ pmbootstrap install --sdcard=/hostdev/sdf # replace "sdf" with your sdcard device
```

Useful extra packages (for me / my PinePhone, running `xfce4`):

- `coreutils` ?
- `tzdata` (https://wiki.alpinelinux.org/wiki/Setting_the_timezone)
- `vim`
- `xinput` (`xinput map-to-output 'pointer:Goodix Capacitive TouchScreen' 'DSI-1'`)
- `xrandr`
- `xset`
- TODO https://github.com/fourdollars/x11-touchscreen-calibrator (can't work as-is -- will ignore DSI)
