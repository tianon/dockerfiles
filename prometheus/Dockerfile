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
ENV PROMETHEUS_VERSION 3.11.3

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
		'prometheus-3.11.3.linux-386.tar.gz') sha256='a643d71963666899a3cf96230dcdfeac938de7ba6722e3b627cf6d2f3388ab9b' ;; \
		'prometheus-3.11.3.linux-amd64.tar.gz') sha256='9479af67673316278958cda1f39b88a09f8921084e039c65acca060d0447bb38' ;; \
		'prometheus-3.11.3.linux-arm64.tar.gz') sha256='d2ec0a96259afde955ad1560ced303cef99cac4dac676bd4dd7614d76adb708a' ;; \
		'prometheus-3.11.3.linux-armv5.tar.gz') sha256='522a40985a6be4c016e14ce2632a02fe268e89940b952a67046996d4891b4e43' ;; \
		'prometheus-3.11.3.linux-armv6.tar.gz') sha256='a7620333f0204965c462b6119b261a5b952849dbb9c4dafb7d15a4d693837f75' ;; \
		'prometheus-3.11.3.linux-armv7.tar.gz') sha256='ceb08da12dba05c0733edeeeb3db031ffb693b03f173c5221808733360a00f25' ;; \
		'prometheus-3.11.3.linux-mips.tar.gz') sha256='002f1df7dd5c06b3e856a5659126e47eb4d7e31978a080fd53d30ad54b9e2ac0' ;; \
		'prometheus-3.11.3.linux-mips64.tar.gz') sha256='7172a4ab3e7fa95264a3207c587bab1c32e27435d78a73a95467b6200075a0cf' ;; \
		'prometheus-3.11.3.linux-mips64le.tar.gz') sha256='8a096f139de5d2584e50daf86103d82817de4eaf295eeb40a191f23ecccf0145' ;; \
		'prometheus-3.11.3.linux-mipsle.tar.gz') sha256='56864459d2e4160e669565e9993e6383de68cb7c534e223925dcc65bfaee3f57' ;; \
		'prometheus-3.11.3.linux-ppc64.tar.gz') sha256='211d64e8ec67f5b6b463003565317c33366cff08ada29c523e71d684231eea9c' ;; \
		'prometheus-3.11.3.linux-ppc64le.tar.gz') sha256='1f77243fbc7fe0c78cb86bdf6fa2c6abecb8a22aaf12dd070ad83bd92281dea4' ;; \
		'prometheus-3.11.3.linux-riscv64.tar.gz') sha256='bd6978937d64f4afa82919e0c4b3b83ace50808b953ab6174e480ca7dda2ba9a' ;; \
		'prometheus-3.11.3.linux-s390x.tar.gz') sha256='9010ce2de8d0d703e840a7cf002ae48aa499703d4ee9b61005ba0a66f81df1cd' ;; \
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
