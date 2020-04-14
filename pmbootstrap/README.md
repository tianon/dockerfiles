```console
$ mkdir "$HOME/some-pmbootstrap-path"
$ docker run -it --rm \
	--mount type=bind,src="$HOME/some-pmbootstrap-path",dst=/work,bind-propagation=rslave \
	--workdir /work \
	--env HOME=/work \
	--user "$(id -u):$(id -g)" \
	--group-add wheel \
	--mount type=bind,src=/etc/passwd,dst=/etc/passwd,ro \
	--mount type=bind,src=/etc/localtime,dst=/etc/localtime,ro \
	--mount type=bind,src=/etc/timezone,dst=/etc/timezone,ro \
	--device-cgroup-rule 'a 8:* rwm' \
	--mount type=bind,src=/dev,dst=/hostdev,ro,bind-propagation=rslave \
	--cap-add SYS_ADMIN \
	--security-opt apparmor=unconfined \
	tianon/pmbootstrap
/work $ pmbootstrap init
/work $ pmbootstrap install --sdcard=/hostdev/sdf # replace "sdf" with your sdcard device
```

Useful extra packages (for me / my PinePhone, running `xfce4`):

- `alsa-utils` (`amixer`, `alsamixer`)
- `bash-completion`
- `coreutils` ?
- `matchbox-keyboard` (on-screen keyboard; `corekeyboard` is another alternative)
- `tzdata` (https://wiki.alpinelinux.org/wiki/Setting_the_timezone)
- `vim`
- `x11vnc` (for controlling X11 remotely, esp. via SSH)
- `xdotool` (for simulating input to X11, esp. via SSH)
- `xinput` (`xinput map-to-output 'pointer:Goodix Capacitive TouchScreen' 'DSI-1'`)
- `xrandr`
- `xset`
- TODO https://github.com/fourdollars/x11-touchscreen-calibrator (can't work as-is -- will ignore DSI)
