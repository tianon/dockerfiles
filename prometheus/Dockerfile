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
ENV PROMETHEUS_VERSION 3.3.1

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
		'prometheus-3.3.1.linux-386.tar.gz') sha256='62cf3b5d1a03916997f3149362ca28e4cad5ae048331dd37535185b5ab8a3f24' ;; \
		'prometheus-3.3.1.linux-amd64.tar.gz') sha256='e22600b314f65fd180fe17c0afeea85ed8484e924fc589c2331b084813699ef0' ;; \
		'prometheus-3.3.1.linux-arm64.tar.gz') sha256='6e3b24c13c55bb2f0e05248327276e6ad6e96ceea4865296a41cbbc092dd45ea' ;; \
		'prometheus-3.3.1.linux-armv5.tar.gz') sha256='50a31c5042c08721a72bb0a99a899f0e882bb82f6b02999cecd3ea39f9f3356c' ;; \
		'prometheus-3.3.1.linux-armv6.tar.gz') sha256='eeb48b69c43b68335d9ab394a0dea9b5ceca8b1d23e272a17934d76a196e59fe' ;; \
		'prometheus-3.3.1.linux-armv7.tar.gz') sha256='78c5f6b3a0a5f04a9bbfe7a5396e3826d73082226f4712f8ab2f99eedc0a10ee' ;; \
		'prometheus-3.3.1.linux-mips.tar.gz') sha256='b4a36b66952683f8e1e94372f9d75b764d83391910a56f8327e63f87babcad18' ;; \
		'prometheus-3.3.1.linux-mips64.tar.gz') sha256='cd3ef7a68b437cb588ee44e7a47781b1dae7376c6e2099a36efd993ba0ff1284' ;; \
		'prometheus-3.3.1.linux-mips64le.tar.gz') sha256='b4659e1c0fbe0ffcba1fab774221711f963d2f4fee5a6a411ff71dbad01ab85b' ;; \
		'prometheus-3.3.1.linux-mipsle.tar.gz') sha256='7c7bd039ab3c81096278ad6789198aab0b14ac9354016ab62e38a026cb3df31e' ;; \
		'prometheus-3.3.1.linux-ppc64.tar.gz') sha256='f1931b3b1300176eb224344a83570407d5b1fbe29e979c13516c2663e75c87c5' ;; \
		'prometheus-3.3.1.linux-ppc64le.tar.gz') sha256='aaa5f2af80877b0e6002b5f3e3232fcfb66e74e05c86a8332a3f6cf988bd42fd' ;; \
		'prometheus-3.3.1.linux-riscv64.tar.gz') sha256='d34285b0cffe362eba4bdbb0c7b4ce0ea67f4595bded40505e3b4f6fb0b4059a' ;; \
		'prometheus-3.3.1.linux-s390x.tar.gz') sha256='4c6583ea784d9adc905331c9327066351a7ba331d0b3a5047fbf95a141facdeb' ;; \
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
