#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.19

RUN apk add --no-cache bash ca-certificates

WORKDIR /opt/prometheus
ENV PATH /opt/prometheus:$PATH

# https://github.com/prometheus/prometheus/releases
ENV PROMETHEUS_VERSION 2.51.2

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
		'prometheus-2.51.2.linux-386.tar.gz') sha256='9fa353c7e849b2f7148a1c8b8e77d60a6efb136d8019158e04105631a21fffaf' ;; \
		'prometheus-2.51.2.linux-amd64.tar.gz') sha256='9bec7432fb92d80fdc193a0154f6c53653c37f8302528b06d63cf4a10a8b897f' ;; \
		'prometheus-2.51.2.linux-arm64.tar.gz') sha256='f246bd6502c95de2cd483e22806bffcd7f2f273b722c9c2a7642f86fa4c8064b' ;; \
		'prometheus-2.51.2.linux-armv5.tar.gz') sha256='502a757021728610086bcad555b3af0bb5f53d17e48a23ed72bed9a545bf1588' ;; \
		'prometheus-2.51.2.linux-armv6.tar.gz') sha256='1134d7aa505bd9f935e161815dc466bc20984465a591bf9ce20a67af8551e1ea' ;; \
		'prometheus-2.51.2.linux-armv7.tar.gz') sha256='bf27ba6cb0b7967b2fd044c9fbdda6db8d9e15cf5350715270c1c9b26bebecde' ;; \
		'prometheus-2.51.2.linux-mips.tar.gz') sha256='e6af98f598a2f15f0037599c24dcfd53c2e6ff796bb81e0a96ca3cb4aafcf6b6' ;; \
		'prometheus-2.51.2.linux-mips64.tar.gz') sha256='41b9c3f958e67325a65db8770a89c60c22cb32fc22e65707b8f1dbea1369403d' ;; \
		'prometheus-2.51.2.linux-mips64le.tar.gz') sha256='062fc9b16c62e4a80ec4a1206d006e307cbf3329eaa008abcc98b34324d3b890' ;; \
		'prometheus-2.51.2.linux-mipsle.tar.gz') sha256='20f1576dae2c23ed18906c4bde36b3ec25daed9a16002fc386049ee443ce146c' ;; \
		'prometheus-2.51.2.linux-ppc64.tar.gz') sha256='41b5c4173fd40fa1fa8304987e23cf8e09bc345b39aa2f185c7b0592ffa81181' ;; \
		'prometheus-2.51.2.linux-ppc64le.tar.gz') sha256='344d478dfe44da8c0bb61b9b3e25c71ed7e2b995a0aeb505b867f462602b0bd6' ;; \
		'prometheus-2.51.2.linux-riscv64.tar.gz') sha256='6d9c6799706dc44cfe4e08a7c463b01607a556ee0981c1430b75e7f2f6884f63' ;; \
		'prometheus-2.51.2.linux-s390x.tar.gz') sha256='4586d0290bd77783f506190845ac7a95951fa9fca9f4da06bb5a8cfa7fad3acf' ;; \
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
