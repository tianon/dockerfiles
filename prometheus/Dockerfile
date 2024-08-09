#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.20

RUN apk add --no-cache bash ca-certificates

WORKDIR /opt/prometheus
ENV PATH /opt/prometheus:$PATH

# https://github.com/prometheus/prometheus/releases
ENV PROMETHEUS_VERSION 2.54.0

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
		'prometheus-2.54.0.linux-386.tar.gz') sha256='685639bdf95c7e6a3fb5cab5a07fe88b0a690220778a979e34bc11f1f7e8abae' ;; \
		'prometheus-2.54.0.linux-amd64.tar.gz') sha256='465e1393a0cca9705598f6ffaf96ffa78d0347808ab21386b0c6aaec2cf7aa13' ;; \
		'prometheus-2.54.0.linux-arm64.tar.gz') sha256='ed50b67cb833a225ec2a53b487c6e20372b20e56dce226423fa8611c8aa50392' ;; \
		'prometheus-2.54.0.linux-armv5.tar.gz') sha256='07483797a06c344c9dbe2a9f733babe9508ad94840f34955997eda6f89636e44' ;; \
		'prometheus-2.54.0.linux-armv6.tar.gz') sha256='0e73625b2496134f886f9853bb581fc568d2b53e38d17f89d6231d3c0b60837a' ;; \
		'prometheus-2.54.0.linux-armv7.tar.gz') sha256='91a071b0098bce789aa44b5a6a455c4cec01279ecc27c9afaa2232eca0f15efd' ;; \
		'prometheus-2.54.0.linux-mips.tar.gz') sha256='08e4f3b1d654be25439b8ad410189b355a84116d07cfe7927bf75cc45dbb98f1' ;; \
		'prometheus-2.54.0.linux-mips64.tar.gz') sha256='62ddf6389984cd2bd4eac764f6fd329f7b507f48129a90d9f8729adbb3d16521' ;; \
		'prometheus-2.54.0.linux-mips64le.tar.gz') sha256='259941bec3ee3b0aa013fb30eb8323cca5ccee1d6b88d83456510fd564b79791' ;; \
		'prometheus-2.54.0.linux-mipsle.tar.gz') sha256='4d9d2e44b2f1b6fc85a55bb0e9dd5a76d1dc36e9eb992159dc05e8023fc33f16' ;; \
		'prometheus-2.54.0.linux-ppc64.tar.gz') sha256='3ec987a77db2050313f5298c8587b41df93b9961e48af0d24b0379d048cad2a5' ;; \
		'prometheus-2.54.0.linux-ppc64le.tar.gz') sha256='830720aac0082c00a88f913cfd7a7471743f2ff22396875080efc5fa69366d68' ;; \
		'prometheus-2.54.0.linux-riscv64.tar.gz') sha256='7757ac501d3d3ae7088a25957d535c2709c1fdfe0b1916f95516e6978cf376c9' ;; \
		'prometheus-2.54.0.linux-s390x.tar.gz') sha256='ebd49584e33899f9391e9322e0e071594de3a2ab0843da4e320d39cc5d1322fe' ;; \
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
