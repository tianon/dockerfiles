Usage:

Either bind-mount or `COPY` into `/etc/kgb-bot/kgb.conf.d/some-file.conf` a configuration similar to the following:
```yaml
---
repositories:
  # just a name to identify it
  foo:
    # needs to be the same on the client
    password: ~
    # private repositories aren't announced to broadcast channels
    # private: yes
# Some witty answer for people that talk to the bot
#smart_answers:
#  - "I wont speak with you!"
#  - "Do not disturb!"
#  - "Leave me alone, I am buzy!"
# Admins are allowed some special !commands (currently only !version)
#admins:
#  - some!irc@mask
#  - some!other@host
networks:
  freenode:
    nick: KGB
    ircname: KGB bot
    username: kgb
    password: ~
    nickserv_password: ~
    server: irc.freenode.net
    port: 6667
channels:
# a broadcast channel
  - name: '#commits'
    network: freenode
    broadcast: yes
# a channel, tied to one or several repositories
  - name: '#foo'
    network: freenode
    repos:
      - foo
    # Can also be set per-channel
    #smart_answers:
    #  - "I'm in ur channel, watching ur commits!"
    #  - "I am not listening"
    #  - "Shut up! I am buzy watching you."
```

See also [the `kgb.conf` documentation](https://kgb.alioth.debian.org/kgb.conf.html).
