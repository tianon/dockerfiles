FROM debian:jessie-slim

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		ca-certificates \
		file \
		net-tools \
		ppp \
		wget \
	&& rm -rf /var/lib/apt/lists/*

# https://sslvpn.demo.sonicwall.com
#   u: demo    p: password

RUN set -ex; \
	wget -O netextender.tgz 'https://sslvpn.demo.sonicwall.com/NetExtender.x86_64.tgz'; \
	tar -xvf netextender.tgz -C /opt/; \
	rm netextender.tgz; \
	( \
		cd /opt/netExtenderClient; \
		./install; \
	); \
	rm -rf /opt/netExtenderClient

# NetExtender connected successfully. Type "Ctrl-c" to disconnect...
STOPSIGNAL SIGINT

CMD ["netExtender"]
