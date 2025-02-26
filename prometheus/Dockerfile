#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.21

RUN apk add --no-cache bash ca-certificates

WORKDIR /opt/prometheus
ENV PATH /opt/prometheus:$PATH

# https://github.com/prometheus/prometheus/releases
ENV PROMETHEUS_VERSION 3.2.1

RUN set -ex; \
	\
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) promArch='arm64'   ;; \
		armhf)   promArch='armv6'   ;; \
		armv7)   promArch='armv7'   ;; \
		ppc64le) promArch='ppc64le' ;; \
		riscv64) promArch='riscv64' ;; \
		s390x)   promArch='s390x'   ;; \
		x86)     promArch='386'     ;; \
		x86_64)  promArch='amd64'   ;; \
		*) echo >&2 "error: unsupported arch: $apkArch"; exit 1 ;; \
	esac; \
	\
	filename="prometheus-${PROMETHEUS_VERSION}.linux-${promArch}.tar.gz"; \
	case "$filename" in \
		'prometheus-3.2.1.linux-386.tar.gz') sha256='e1b222c4d6a3bbaff2412173cbd25d38e3927835464251c27097a2a2ee9c4939' ;; \
		'prometheus-3.2.1.linux-amd64.tar.gz') sha256='a622e3007c9109a7f470e1433cbd29bf392596715cf7eea8b81b37fa9d26b7be' ;; \
		'prometheus-3.2.1.linux-arm64.tar.gz') sha256='f2dec3178f1181c1b795b275750d056e71ead13f7fbfe08b76834c4ec20b748e' ;; \
		'prometheus-3.2.1.linux-armv5.tar.gz') sha256='4e977dc60ff80255662f40eaf7c7d602e8c7e56bb6b93baebaf2b6cab86c1b7e' ;; \
		'prometheus-3.2.1.linux-armv6.tar.gz') sha256='c6e019d7db1f9e324cf54718596da431a2692baba524efd7ab026c4020a2ae16' ;; \
		'prometheus-3.2.1.linux-armv7.tar.gz') sha256='5ccebc05700bf4f1c8adb577977e3b7a65a3a0e3581d33d58204e24ef50e2088' ;; \
		'prometheus-3.2.1.linux-mips.tar.gz') sha256='ff0c16b63a3b8eadb8232ead82bc278ef03a6b5661c0c1930e843361c9fb5bd5' ;; \
		'prometheus-3.2.1.linux-mips64.tar.gz') sha256='882b097ba377a6f7db727310e5c3ba37866297243a89fe4303bedf4230bf8209' ;; \
		'prometheus-3.2.1.linux-mips64le.tar.gz') sha256='fa2259191fc92879f3b88944bf3183b5d0bb63077ae62f0d3071936b743b56a2' ;; \
		'prometheus-3.2.1.linux-mipsle.tar.gz') sha256='9fd97352fb5f501d3f1fa904982b598ba6e040baf06cbcda3ba8f7db2bfcaeb0' ;; \
		'prometheus-3.2.1.linux-ppc64.tar.gz') sha256='9dbe925df573a81359929b2df834cb77e7c1ffc5e3e251dd06780e568b9a0e69' ;; \
		'prometheus-3.2.1.linux-ppc64le.tar.gz') sha256='19ca0e92e247ed806464f08fec65dcc06f35be30033745b40e0fc411f41cb1e6' ;; \
		'prometheus-3.2.1.linux-riscv64.tar.gz') sha256='5c3e069086f0c1e950d03d444611f33586f2c5f0bdb4df9ac89e53c6831baf8a' ;; \
		'prometheus-3.2.1.linux-s390x.tar.gz') sha256='1ef73ddcf2be28ba36090bc6af61c6fd9a8d17891156a2c61cf62ebf0cdc90c5' ;; \
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
