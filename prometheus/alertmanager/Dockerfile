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
ENV ALERTMANAGER_VERSION 0.35.0

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
		'alertmanager-0.35.0.linux-386.tar.gz') sha256='118bee833f12c22b093bde50615cdeb87a35151c6d90572616296c8c51889867' ;; \
		'alertmanager-0.35.0.linux-amd64.tar.gz') sha256='6c7752a903c40c8a749e0b29df9240437e4fbb8228068d0af8807377db32addd' ;; \
		'alertmanager-0.35.0.linux-arm64.tar.gz') sha256='b7a8a69f849c6f837348b05476195862152f9de8eae338eb36ab29801d341654' ;; \
		'alertmanager-0.35.0.linux-armv5.tar.gz') sha256='1200685db0b0ee23726b7c7e9482ae0778f562a5ca95073c44e5c20fa8b39e31' ;; \
		'alertmanager-0.35.0.linux-armv6.tar.gz') sha256='6f5779c755c28d19d245d9a217b1fa26c960c59667eb6cad13248e7519c958e5' ;; \
		'alertmanager-0.35.0.linux-armv7.tar.gz') sha256='2074ce71497ae9eec112a11a2a47878cfa0b2fd304fb6814f654bd5172ffb269' ;; \
		'alertmanager-0.35.0.linux-mips.tar.gz') sha256='615fa7307f3d1981665c09e5512e14380d7ad0d73f67d3fb80a6b873808b3de5' ;; \
		'alertmanager-0.35.0.linux-mips64.tar.gz') sha256='6d81dac184b9926972c7f4403c4a194bfd91ca897d7751164f63d0765eeedd4a' ;; \
		'alertmanager-0.35.0.linux-mips64le.tar.gz') sha256='f5b09251ff1af7d7537466e0ef7f34bd4fea75917373f12f0cc5e356fdee0dc9' ;; \
		'alertmanager-0.35.0.linux-mipsle.tar.gz') sha256='fe81327b25c851fc25fc2ef6b6c075d9e754e465178afdf5cb14e5bb61c51730' ;; \
		'alertmanager-0.35.0.linux-ppc64.tar.gz') sha256='7b7f92fee08670d9fa1de32cfdbf598a8db0534e34fc54b700f2ef6581e89778' ;; \
		'alertmanager-0.35.0.linux-ppc64le.tar.gz') sha256='e6f5e60a83ab6d4e46e702978b4fa589e89800fe2e5035301a1dbdfba1e0cbfb' ;; \
		'alertmanager-0.35.0.linux-riscv64.tar.gz') sha256='8a273f1e4ebcd2756ac117e6f6e3c1f19faf86c71ea09ddaeb124a1b08799464' ;; \
		'alertmanager-0.35.0.linux-s390x.tar.gz') sha256='160b598fe45cf62382a7a280d06df4144eb0540123187587b73555e9d7c56d81' ;; \
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
