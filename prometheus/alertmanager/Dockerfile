#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.21

RUN apk add --no-cache bash ca-certificates

WORKDIR /opt/alertmanager
ENV PATH /opt/alertmanager:$PATH

# https://github.com/prometheus/alertmanager/releases
ENV ALERTMANAGER_VERSION 0.28.0

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
		'alertmanager-0.28.0.linux-386.tar.gz') sha256='80b97cfe25381e37e742d22fdb032585645d99b68b910e9e46ccb96631f41c0c' ;; \
		'alertmanager-0.28.0.linux-amd64.tar.gz') sha256='6b5a38d32cddef23aad4435a58c1ea39dc0a07b4b155029c601d200720da9ca4' ;; \
		'alertmanager-0.28.0.linux-arm64.tar.gz') sha256='70d7c85a364d5d5d20e36dfff6886fbc5e105822642d5603cc2f38340dd2f7ee' ;; \
		'alertmanager-0.28.0.linux-armv5.tar.gz') sha256='b06243a8eba21970295c39b36121cc9227daba872f472524fc45d491970c5222' ;; \
		'alertmanager-0.28.0.linux-armv6.tar.gz') sha256='92312fa4e13857b2eecf1b99a664040a709a1570fe84cfda34950b36e81d8f9d' ;; \
		'alertmanager-0.28.0.linux-armv7.tar.gz') sha256='919e1dcf773955899aa531bd13636a926798ed8b7c6d9ae4c6b7c3c00a846df9' ;; \
		'alertmanager-0.28.0.linux-mips.tar.gz') sha256='5f4a40e510ee40da9da85a2fb204bbee65e859cc0de15327243bb8d53a8345f7' ;; \
		'alertmanager-0.28.0.linux-mips64.tar.gz') sha256='ac6c3f37ae9c613ef96b08d851b7aaf4aa203d6021ba90cb334358ea17d90058' ;; \
		'alertmanager-0.28.0.linux-mips64le.tar.gz') sha256='dca4d3f7865338f848bff143afaf7aefddf0b3b17eea35a6a8c8d95784c57057' ;; \
		'alertmanager-0.28.0.linux-mipsle.tar.gz') sha256='6422bc5b2af0fd9e4504ae3f2bc7149691211cb9e3cd250d46777d9e82ced0be' ;; \
		'alertmanager-0.28.0.linux-ppc64.tar.gz') sha256='688a7849e2dd82f7f2900f5bc9e69b2318aea5e8bb08b9a883d2d17c98e772e7' ;; \
		'alertmanager-0.28.0.linux-ppc64le.tar.gz') sha256='7857ee89d349502b7b7db5449339e19146e3b1a5489a5574137529671010f056' ;; \
		'alertmanager-0.28.0.linux-riscv64.tar.gz') sha256='a260aacbcc3acce7f6d66fb03b4d62a6d1df227ef22e60cb334605c63f0de52e' ;; \
		'alertmanager-0.28.0.linux-s390x.tar.gz') sha256='d0de880cc69b3d117ad7e8c366fa9571f9a7082ef5fa968f33d6e86e0ebdde8f' ;; \
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
