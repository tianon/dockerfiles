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
ENV ALERTMANAGER_VERSION 0.32.0

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
		'alertmanager-0.32.0.linux-386.tar.gz') sha256='ac4e0d8b0ea4fb2fa6e7857053799e4ed5a8c540bfe1c4c2c028e6c7a077083c' ;; \
		'alertmanager-0.32.0.linux-amd64.tar.gz') sha256='be72f50f6124ec53d944c0f100f8ec8108d969bade02fcc9f06a3068ff6c726f' ;; \
		'alertmanager-0.32.0.linux-arm64.tar.gz') sha256='7812e12699694974f57ecc0b0400913c6c0d90190630d4332a7994a44982b1ed' ;; \
		'alertmanager-0.32.0.linux-armv5.tar.gz') sha256='48006931dbf25f26dd27f56546ba8ed86712ad7eb5cb3e335ff85a892b9e29bf' ;; \
		'alertmanager-0.32.0.linux-armv6.tar.gz') sha256='fed428978d6a9cb7404f100d5a32871c7e3da993c0603b03b6d15c5c49cae5d3' ;; \
		'alertmanager-0.32.0.linux-armv7.tar.gz') sha256='1be0e4ffb5b2846f2f56edc19ac1e7b579eecc8d453f6098c227b0da8d92edf3' ;; \
		'alertmanager-0.32.0.linux-mips.tar.gz') sha256='a5e6907fdda07fa37ba0bcde00d9d9dfbc08a6a002cf81bed4e8e6f6577933f3' ;; \
		'alertmanager-0.32.0.linux-mips64.tar.gz') sha256='d00c82dbe1ad68505e92720a4c7e99895391da440c96da82b3ec47363416455b' ;; \
		'alertmanager-0.32.0.linux-mips64le.tar.gz') sha256='67133a1292d042db2617936574683acd3b80caf1030a2e397744b31b0f2a45e7' ;; \
		'alertmanager-0.32.0.linux-mipsle.tar.gz') sha256='8d4534b40dcc884971bfd706f071ee3b0415cabf918d7621b2b5bafc4c5fb485' ;; \
		'alertmanager-0.32.0.linux-ppc64.tar.gz') sha256='469a1912ff5a66d2fd070cdf2df1de9b90ee58f141e3235e258d8e526522300e' ;; \
		'alertmanager-0.32.0.linux-ppc64le.tar.gz') sha256='b4f255d9ce4855184fe29c2c161b8d51f21cc9239c0e7fe4865b9755206aad95' ;; \
		'alertmanager-0.32.0.linux-riscv64.tar.gz') sha256='b064e9efe80f85534cda72b6a6c5b79abfdf6e3b8740f83b014db88ad625a9e8' ;; \
		'alertmanager-0.32.0.linux-s390x.tar.gz') sha256='d9089c316538f3083029a9279f75ab822e2ca9a186ff965e55e582976d724b2e' ;; \
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
