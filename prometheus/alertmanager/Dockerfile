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
ENV ALERTMANAGER_VERSION 0.29.0

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
		'alertmanager-0.29.0.linux-386.tar.gz') sha256='c837766bc2f131011c96de8c1cda8b79220fa43749fb592cbf7d473460350d8b' ;; \
		'alertmanager-0.29.0.linux-amd64.tar.gz') sha256='3b12d6dac67eef1cfbe42c6153f156e7b968e6f04298b4d966d51ba5e271a1b3' ;; \
		'alertmanager-0.29.0.linux-arm64.tar.gz') sha256='1fee609a753abc91c06b120f19d0f47cd7ae127210c546ffb6afb2819ce62913' ;; \
		'alertmanager-0.29.0.linux-armv5.tar.gz') sha256='17c2f395619fe7bb84560af81eb51dc3f082ccaab557451477769f53e457188e' ;; \
		'alertmanager-0.29.0.linux-armv6.tar.gz') sha256='f5bdb05cb412682c174140f62a2677e21675f861e62420ca05cfec81cac97704' ;; \
		'alertmanager-0.29.0.linux-armv7.tar.gz') sha256='f5b7a2309763a0f8646b39af33c8778c1af989db939656ea1234142038d8998d' ;; \
		'alertmanager-0.29.0.linux-mips.tar.gz') sha256='fbe645d4d321de8e7eb35b6a986a0bcd302663ef14329672d944eb2ae275b9db' ;; \
		'alertmanager-0.29.0.linux-mips64.tar.gz') sha256='c835ddff6686f63812d59598efdf5de32590b1afd5c662942ea3b1159706c106' ;; \
		'alertmanager-0.29.0.linux-mips64le.tar.gz') sha256='ee26e1a7abafbaffc4aecefc5a7502bb5a8219b98742aa6cb66ac64cb099e594' ;; \
		'alertmanager-0.29.0.linux-mipsle.tar.gz') sha256='492893c21895fb7e2256b87ccdcd267a21d4a342e8202eabd3f9264eb552b48a' ;; \
		'alertmanager-0.29.0.linux-ppc64.tar.gz') sha256='44e47bbb5b59872e107168f5bfdb578874b257a3f5e4b2db58e522f28499f96b' ;; \
		'alertmanager-0.29.0.linux-ppc64le.tar.gz') sha256='6cacbadb7bb669df008f7a3a94c3eae99098d6af3667068bdac76a86263e5af8' ;; \
		'alertmanager-0.29.0.linux-riscv64.tar.gz') sha256='704ec75762609686bf345b0cd410ab99dcfb1b5508a4dc5778089eeb49b40535' ;; \
		'alertmanager-0.29.0.linux-s390x.tar.gz') sha256='f982300a1143903eaac226a8baddd225203364264f18e64642b273d4b436c325' ;; \
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
