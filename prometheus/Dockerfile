#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.20

RUN apk add --no-cache bash ca-certificates

WORKDIR /opt/prometheus
ENV PATH /opt/prometheus:$PATH

# https://github.com/prometheus/prometheus/releases
ENV PROMETHEUS_VERSION 2.54.1

RUN set -ex; \
	\
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) promArch='arm64'   ;; \
		armhf)   promArch='armv6'   ;; \
		armv7)   promArch='armv7'   ;; \
		ppc64le) promArch='ppc64le' ;; \
		s390x)   promArch='s390x'   ;; \
		x86)     promArch='386'     ;; \
		x86_64)  promArch='amd64'   ;; \
		*) echo >&2 "error: unsupported arch: $apkArch"; exit 1 ;; \
	esac; \
	\
	filename="prometheus-${PROMETHEUS_VERSION}.linux-${promArch}.tar.gz"; \
	case "$filename" in \
		'prometheus-2.54.1.linux-386.tar.gz') sha256='49e5f06a4e4c86db14f3708a59acf19e014d1023aa04f9a4b611c28c2fefa8b1' ;; \
		'prometheus-2.54.1.linux-amd64.tar.gz') sha256='31715ef65e8a898d0f97c8c08c03b6b9afe485ac84e1698bcfec90fc6e62924f' ;; \
		'prometheus-2.54.1.linux-arm64.tar.gz') sha256='3d9946ca730f2679bbd63e9d40e559a0ba227a638d237e723af1a99bd7098263' ;; \
		'prometheus-2.54.1.linux-armv5.tar.gz') sha256='c9a0c56d7ce667ae9ace2b6db048ebaf9b2621ce52b4fcf9e73678a312e3e7dd' ;; \
		'prometheus-2.54.1.linux-armv6.tar.gz') sha256='0e0d55dfc8e6bea2f75f756db3ed0034f96ad83cb70cf55fad7791c378f114a2' ;; \
		'prometheus-2.54.1.linux-armv7.tar.gz') sha256='704821beac972a1e232cf2daad1dc159733a20a429a4d24cb2e19d1b7b5dca4d' ;; \
		'prometheus-2.54.1.linux-mips.tar.gz') sha256='1f78023ab7e888f55730eea9d414f27f560515ecd257cf5e75bea9ff09e51e86' ;; \
		'prometheus-2.54.1.linux-mips64.tar.gz') sha256='a96a448d4c175894554d4a41a7910b67f3d17f51c6dc669ecbb78a7527ba0825' ;; \
		'prometheus-2.54.1.linux-mips64le.tar.gz') sha256='446720c181206ced7a45133bd1c63de173186e1d6fbc432e427eca30dd165d9c' ;; \
		'prometheus-2.54.1.linux-mipsle.tar.gz') sha256='433559f0f0e09aa850f3b18abf79b88185451e1621231bc608b0873d69ba36d0' ;; \
		'prometheus-2.54.1.linux-ppc64.tar.gz') sha256='df11d5b627a405a3cfd200a76a6c2d8cde6a52d348ca22b3a79af0306ea2c770' ;; \
		'prometheus-2.54.1.linux-ppc64le.tar.gz') sha256='fcc494f874edef7053abef0a92070dd5fb3dbcce9b44f18839fa68a6e10337a1' ;; \
		'prometheus-2.54.1.linux-riscv64.tar.gz') sha256='eab1e4e0fcb0c6a3603a67b032bbe2d25006c48499293dc53119529c9164e07c' ;; \
		'prometheus-2.54.1.linux-s390x.tar.gz') sha256='56f6dfa71853b8d39ccc79b2bd7f55bc7c1d2e1e10f4b226f29e57143836d493' ;; \
		*) echo >&2 "error: unknown file: $filename"; exit 1 ;; \
	esac; \
	wget -O /tmp/prom.tar.gz "https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/$filename"; \
	echo "$sha256 */tmp/prom.tar.gz" | sha256sum -c -; \
	\
	tar \
		--extract \
		--file /tmp/prom.tar.gz \
		--strip-components 1 \
		--verbose \
	; \
	rm /tmp/prom.tar.gz; \
	\
	prometheus --version

VOLUME /opt/prometheus/data
EXPOSE 9090

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD []
