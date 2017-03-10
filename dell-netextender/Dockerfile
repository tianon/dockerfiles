FROM debian:jessie-slim

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		ca-certificates \
		file \
		net-tools \
		ppp \
		wget \
	&& rm -rf /var/lib/apt/lists/*

ENV DELL_NETEXTENDER_VERSION 8.5.797

RUN set -ex; \
# https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=netextender
	wget -O netextender.tgz "https://sslvpn.demo.sonicwall.com/NetExtender.Linux.${DELL_NETEXTENDER_VERSION}.x86_64.tgz"; \
	tar -xvf netextender.tgz -C /opt/; \
	rm netextender.tgz; \
	( \
		cd /opt/netExtenderClient; \
		./install; \
	); \
	rm -rf /opt/netExtenderClient

CMD ["netExtender"]
