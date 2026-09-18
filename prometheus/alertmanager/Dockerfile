#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.23

RUN apk add --no-cache bash ca-certificates tzdata

WORKDIR /opt/alertmanager
ENV PATH /opt/alertmanager:$PATH

# https://github.com/prometheus/alertmanager/releases
ENV ALERTMANAGER_VERSION 0.34.1

RUN set -eux; \
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
	filename="alertmanager-${ALERTMANAGER_VERSION}.linux-${promArch}.tar.gz"; \
	case "$filename" in \
		'alertmanager-0.34.1.linux-386.tar.gz') sha256='e4717ae5f4eb37c833e6deb9e188f2405ec668ac05d7d61c94e74efbb761f24c' ;; \
		'alertmanager-0.34.1.linux-amd64.tar.gz') sha256='265b9d1e55ef0d5306a436018af6d2b686c2ce051f03d968f7464ecb1372a7e8' ;; \
		'alertmanager-0.34.1.linux-arm64.tar.gz') sha256='d98d6cbaf52151c7e76e24355fec88b11cebcb9875d4cdd8b76ddce7a7e5535c' ;; \
		'alertmanager-0.34.1.linux-armv5.tar.gz') sha256='9374a8bc4f114b1204a507329ccd75e2dad715d7cee82c03259d40052037d372' ;; \
		'alertmanager-0.34.1.linux-armv6.tar.gz') sha256='7b2727f1c33c6c63045985957322a0476ae47dfdd84da05b609f6d54106e6075' ;; \
		'alertmanager-0.34.1.linux-armv7.tar.gz') sha256='75f568dc43b3f905cc846e71417bbcc1d63d186bc7d95bd87fd2f41b1124d4f3' ;; \
		'alertmanager-0.34.1.linux-mips.tar.gz') sha256='96dd8be900045b00e14a6dd771e4b6438c2c12036ef14fff763c487f88060844' ;; \
		'alertmanager-0.34.1.linux-mips64.tar.gz') sha256='089d23989db39554e52f9dce94c7f75c0872e4c521cff15c58a67ac9332f6ae7' ;; \
		'alertmanager-0.34.1.linux-mips64le.tar.gz') sha256='18c812546f4ddc56de5d235a9c4f35952b0fbbf79b66dfb77dde75bdcacae67a' ;; \
		'alertmanager-0.34.1.linux-mipsle.tar.gz') sha256='0e52158b5235c200d6ee61a427c763b91ba452b90430f6cc211e8256acf573a6' ;; \
		'alertmanager-0.34.1.linux-ppc64.tar.gz') sha256='02b17361a0bb5f0d2c13753289dc137612d11e6f6073da6b00bce1be2cd5eea3' ;; \
		'alertmanager-0.34.1.linux-ppc64le.tar.gz') sha256='823a0332b5ae53476114f94e0a22b349ebbc3b178aaf5924b3a76d322c778d6b' ;; \
		'alertmanager-0.34.1.linux-riscv64.tar.gz') sha256='6d2be3d7d4beba6cbd47c5e314e18d453064e9f20e98bb0e0f1e1e70e0f48d8c' ;; \
		'alertmanager-0.34.1.linux-s390x.tar.gz') sha256='2f6766ef1346d120f3e14950f474839a0863c3a92a4a94eae13ec1150f184d1a' ;; \
		*) echo >&2 "error: unknown file: $filename"; exit 1 ;; \
	esac; \
	wget -O /tmp/alertmanager.tar.gz "https://github.com/prometheus/alertmanager/releases/download/v${ALERTMANAGER_VERSION}/$filename"; \
	echo "$sha256 */tmp/alertmanager.tar.gz" | sha256sum -c -; \
	\
	tar \
		--extract \
		--file /tmp/alertmanager.tar.gz \
		--strip-components 1 \
		--verbose \
	; \
	rm /tmp/alertmanager.tar.gz; \
	\
	mkdir data; \
	\
	alertmanager --version

VOLUME /opt/alertmanager/data
EXPOSE 9093 9094

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD []
