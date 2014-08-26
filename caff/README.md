# tianon/caff

So, I've got a local script called `caff` in my path that looks something like this:

```bash
#!/bin/bash
set -e

exec docker run -it --rm \
	--name caff \
	-e OWNER='John Smith' \
	-e EMAIL='jsmith@example.com' \
	-e KEYS='DEADBEEFCAFEBABE' \
	-v /etc/ssmtp/ssmtp.conf:/etc/ssmtp/ssmtp.conf:ro \
	-v ~jsmith/.gnupg:/home/user/.gnupg \
	tianon/caff "$@"
```

It is then used just like `caff` normally would be: `caff CAFEBEEFBABEDEAD`.
