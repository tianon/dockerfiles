FROM debian:stretch-slim

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
		file \
		net-tools \
		ppp \
		wget \
	; \
	rm -rf /var/lib/apt/lists/*

# https://sslvpn.demo.sonicwall.com
#   u: demo    p: password

RUN set -eux; \
	wget -O netextender.tgz 'https://sslvpn.demo.sonicwall.com/NetExtender.x86_64.tgz'; \
	echo '773849f159db917db6a89b7593849eec9af0f0fc08ba57ccf6db45b07aad3daf *netextender.tgz' | sha256sum --check --strict; \
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
