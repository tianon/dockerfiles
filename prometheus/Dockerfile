#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.23

RUN apk add --no-cache bash ca-certificates

WORKDIR /opt/prometheus
ENV PATH /opt/prometheus:$PATH

# https://github.com/prometheus/prometheus/releases
ENV PROMETHEUS_VERSION 3.11.2

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
		'prometheus-3.11.2.linux-386.tar.gz') sha256='921d59d9a2014bb2d417a48dc54bac0f694367c16f158b8240baf6b8366f4f8b' ;; \
		'prometheus-3.11.2.linux-amd64.tar.gz') sha256='f643ea1ee90d109329302d27bddb1fb2e52655b1fa84e9e26f9a6f340da144a6' ;; \
		'prometheus-3.11.2.linux-arm64.tar.gz') sha256='4e40f115655a3021744137f49287846bc5a59e02835565748ff66b23e776a73d' ;; \
		'prometheus-3.11.2.linux-armv5.tar.gz') sha256='827d95440b1459534c5ea76ff8a9e33495f214990254d5c7b90575af9d1b0cd1' ;; \
		'prometheus-3.11.2.linux-armv6.tar.gz') sha256='cd46844b2f897acaa515a081fef2a21d4c10c57efa360acda85f72e3f2fcec1e' ;; \
		'prometheus-3.11.2.linux-armv7.tar.gz') sha256='0cc413eb6cac911b8803c1bf8539373eab1478097313a7fa4e82bb22a0a17b0d' ;; \
		'prometheus-3.11.2.linux-mips.tar.gz') sha256='0738de33a34b02b88676dbdccf29f4282602212da5ccd91f44a0c191df2e903b' ;; \
		'prometheus-3.11.2.linux-mips64.tar.gz') sha256='c4af5b16d600b200880993d05d8fe56a8645fa703fe2e49be7a8ec3c2fef208d' ;; \
		'prometheus-3.11.2.linux-mips64le.tar.gz') sha256='69ff01fa3c0a7909cce5bc89f929d46620e1e1ce1b361a0417d6b2b8092d443a' ;; \
		'prometheus-3.11.2.linux-mipsle.tar.gz') sha256='32a32101c534f681169b85e7a59f0a875659f0510051c4270bc4e56d832c0a36' ;; \
		'prometheus-3.11.2.linux-ppc64.tar.gz') sha256='57095f203f863e8c15cf0d789fca7a9cdab048888a18051823f3faf6fdf963eb' ;; \
		'prometheus-3.11.2.linux-ppc64le.tar.gz') sha256='5c991576266c20e7fa5393b24e013b1f62bf7a171eb255f0669c8ba3441fa19f' ;; \
		'prometheus-3.11.2.linux-riscv64.tar.gz') sha256='19aa26239e83cf8af52927c94614c0d2e5828920506663e0a2fef519a7e670d8' ;; \
		'prometheus-3.11.2.linux-s390x.tar.gz') sha256='0f2832d33ab6b463254e99871886f5be5e7b394fd18b4b306686052e37c447b3' ;; \
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
