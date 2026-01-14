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
ENV ALERTMANAGER_VERSION 0.30.1

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
		'alertmanager-0.30.1.linux-386.tar.gz') sha256='dc752aad4cb18e636617e223a72c3b9d28d5b690f95e852ac18b4e91fb104e68' ;; \
		'alertmanager-0.30.1.linux-amd64.tar.gz') sha256='79bc54258ba9b039e2c3a23b3bc3d74b699f29070f5d67c41d68d5323e309a26' ;; \
		'alertmanager-0.30.1.linux-arm64.tar.gz') sha256='50255f15d5019e08abe9bf53488689010ca489ff1d0cb8614ba1796fbba2988b' ;; \
		'alertmanager-0.30.1.linux-armv5.tar.gz') sha256='fe9725cc02fad80e80671d31fa87842b66512f42e95cd9ff56d57d09f5fe3492' ;; \
		'alertmanager-0.30.1.linux-armv6.tar.gz') sha256='28fae4204e8abc3d6866667bd33bfe954a51a547304fe78147f2e4ac2c87fabf' ;; \
		'alertmanager-0.30.1.linux-armv7.tar.gz') sha256='da4279e2dee6b9ddd0f9768e2c5fc691f35d5d04544208e8254f4a71265bf59d' ;; \
		'alertmanager-0.30.1.linux-mips.tar.gz') sha256='c3c07fb9a65ff80c80963948bd3af516a427bfd65faa584a849da7123115e297' ;; \
		'alertmanager-0.30.1.linux-mips64.tar.gz') sha256='fbbffd405b98b33d06bcd40c9a01caa3fb277f2197cb00c7f915fb76905d9a9c' ;; \
		'alertmanager-0.30.1.linux-mips64le.tar.gz') sha256='7b692887b9abaca089c2249203ff432bc6fe9038b03c21a8a8296937018b0f79' ;; \
		'alertmanager-0.30.1.linux-mipsle.tar.gz') sha256='f68d3b36a8135f0022a2e071311d454c83a2f8383eb5d4c75fb7729087f06f7b' ;; \
		'alertmanager-0.30.1.linux-ppc64.tar.gz') sha256='38943f6f0a1d45be92a1f51c8dfbcdf37755c0a4798ffdfe549975481c5f1caf' ;; \
		'alertmanager-0.30.1.linux-ppc64le.tar.gz') sha256='8f2d464fe2b38db060db7bcc018e3e24638bc660ceac0e97d5b746550e79e325' ;; \
		'alertmanager-0.30.1.linux-riscv64.tar.gz') sha256='188685000b807b1708fb99ad495593ba3da09f80f51c0586009a9b213835916c' ;; \
		'alertmanager-0.30.1.linux-s390x.tar.gz') sha256='a01c807f1cfe8171edf3b1a0fa5f6fdf0971de4d921ad829ee5f405e708afacc' ;; \
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
