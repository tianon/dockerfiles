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
ENV PROMETHEUS_VERSION 3.9.1

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
		'prometheus-3.9.1.linux-386.tar.gz') sha256='83d73edb1f9cb84e0198b658224a33fcf0cea5f0a1c0d41168bfc76049e01cf2' ;; \
		'prometheus-3.9.1.linux-amd64.tar.gz') sha256='86a6999dd6aacbd994acde93c77cfa314d4be1c8e7b7c58f444355c77b32c584' ;; \
		'prometheus-3.9.1.linux-arm64.tar.gz') sha256='4e7f291e527d8aca912a995c183128388c9e048065aff84f74f5a55c9bef3793' ;; \
		'prometheus-3.9.1.linux-armv5.tar.gz') sha256='f2904d085201ec2826c5894c0548f74d778dbfa2c62a792db1d36e1c495da7ac' ;; \
		'prometheus-3.9.1.linux-armv6.tar.gz') sha256='ea46995bafe9bf2d4bc19c35a13d1e06f3e7b8462da983888e8f1116bb4c115e' ;; \
		'prometheus-3.9.1.linux-armv7.tar.gz') sha256='85abd6e58a87a16041ff5a9b061b4018e95a893449a33d7a4de874030c216993' ;; \
		'prometheus-3.9.1.linux-mips.tar.gz') sha256='58187b06aa9349dda5ced8c5a5c69497fa1b864775868fdacbea97cd9d073772' ;; \
		'prometheus-3.9.1.linux-mips64.tar.gz') sha256='afc7f9f43f427bee09f73455fede5f6e265566a46489f8cde7a4026c30e6dafd' ;; \
		'prometheus-3.9.1.linux-mips64le.tar.gz') sha256='2c4318fb6ecae51bed9efa35dd349dc463ddb03aa371dbdcc60126a48066a3a5' ;; \
		'prometheus-3.9.1.linux-mipsle.tar.gz') sha256='7c760d03110fea9729ed838a89260289878abf4b775246942a8d4580bed12632' ;; \
		'prometheus-3.9.1.linux-ppc64.tar.gz') sha256='0c109c734a8955753284149b3ca28940fcf9469c8552a01035f54479d411f447' ;; \
		'prometheus-3.9.1.linux-ppc64le.tar.gz') sha256='9ed9e272e0f4272415f16cfd7c2e03ebf597e3722161b607aabd8e8a4dc76ba4' ;; \
		'prometheus-3.9.1.linux-riscv64.tar.gz') sha256='927a9d72a61e37d64a3d4e39b33d914d4621783c823a4ca2ec9970765ecb3241' ;; \
		'prometheus-3.9.1.linux-s390x.tar.gz') sha256='5a5f46960e59783f5741c0fcf6d496c76341bf6fc5161cda21e4362f0703b854' ;; \
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
