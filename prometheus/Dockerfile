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
ENV PROMETHEUS_VERSION 3.11.0

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
		'prometheus-3.11.0.linux-386.tar.gz') sha256='98ac64a59bfabfb7f31160da5a0e8c7787d86ea5d2f7b598b6bec65e888c23ce' ;; \
		'prometheus-3.11.0.linux-amd64.tar.gz') sha256='ff799c3e4c318e17dec14aaaa406a4da328fabb4578336b36d96d893870c3b76' ;; \
		'prometheus-3.11.0.linux-arm64.tar.gz') sha256='4d983175e77161e30b94922c49fdb681cf849439613d24a026bbb8d1ca4e8728' ;; \
		'prometheus-3.11.0.linux-armv5.tar.gz') sha256='ef22b43fcd45c6c05aef1f273a76147c2dacb8e108e58e3333764069101f7201' ;; \
		'prometheus-3.11.0.linux-armv6.tar.gz') sha256='b9e55fb241ea32c65ffbae0603d3ee33f80f77a3388fd0a66e943c2ffbe57b0d' ;; \
		'prometheus-3.11.0.linux-armv7.tar.gz') sha256='daa88226f8a0e77be48ec62b9468c1143f9d6e717ffa98ca3bd2d21143f907a5' ;; \
		'prometheus-3.11.0.linux-mips.tar.gz') sha256='5e8bf8c63aa32edf5ea3e00909517f507a352e6f352381bc22be6be793cfc826' ;; \
		'prometheus-3.11.0.linux-mips64.tar.gz') sha256='a6afc854062e79fd81d9f5e81d8b2e1f4aebfd9844af8a6e31829fb08d1af425' ;; \
		'prometheus-3.11.0.linux-mips64le.tar.gz') sha256='6cac082243cb41d8d979828ac6d207650f028f391efb0b96b070c4a519d5b855' ;; \
		'prometheus-3.11.0.linux-mipsle.tar.gz') sha256='ee386cc254dbbc56a26e40d243e30b86109a275769ad8fb3f22b558ec7bd17dc' ;; \
		'prometheus-3.11.0.linux-ppc64.tar.gz') sha256='182a00bf0c7b7a086ca9f2e87a4e07cadb9e29256cff6a4bcde3fbbb70748d33' ;; \
		'prometheus-3.11.0.linux-ppc64le.tar.gz') sha256='b02f86ee6c616d443491c2f1aa858723a51579147864202eff89d722cacc2552' ;; \
		'prometheus-3.11.0.linux-riscv64.tar.gz') sha256='5dd3e062020bee924f5cb73e88e9fcdc8643642e36d8ff40b4a845d1b7803562' ;; \
		'prometheus-3.11.0.linux-s390x.tar.gz') sha256='0a4c74f4bf5f4bb9b93ef895d16b7f381fd9f1b27ad76db5c7f7831a11e944fb' ;; \
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
