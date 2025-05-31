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
ENV PROMETHEUS_VERSION 3.4.1

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
		'prometheus-3.4.1.linux-386.tar.gz') sha256='c0ea17d2214b313807f85e50cb7e89fc282d24575209c0952236720903047dbd' ;; \
		'prometheus-3.4.1.linux-amd64.tar.gz') sha256='09203151c132f36b004615de1a3dea22117ad17e6d7a59962e34f3abf328f312' ;; \
		'prometheus-3.4.1.linux-arm64.tar.gz') sha256='2a85be1dff46238c0d799674e856c8629c8526168dd26c3de2cecfbfc6f9a0a2' ;; \
		'prometheus-3.4.1.linux-armv5.tar.gz') sha256='108a5a3f25c48a269e9c28328f63e10276199fefd7c1d5e4316078c3d6db393f' ;; \
		'prometheus-3.4.1.linux-armv6.tar.gz') sha256='a93a971521580d03ab6f4117640dc255df5517b42fd02ef2e56cb1b57bb2fd5c' ;; \
		'prometheus-3.4.1.linux-armv7.tar.gz') sha256='3a590b504251e25581971bded31e0f664b9d5b7d25ccf205778ce581a0c0fd4c' ;; \
		'prometheus-3.4.1.linux-mips.tar.gz') sha256='db5bf117d5fc99ae3e43e039fe6b73c9a8a6ad9ebe23c70059e0f531742a0518' ;; \
		'prometheus-3.4.1.linux-mips64.tar.gz') sha256='73e6015ed07c90500e8aff8aeedc4a31127f0ded49f6078d710dc3ed457dff91' ;; \
		'prometheus-3.4.1.linux-mips64le.tar.gz') sha256='a41b6ca01b16a8d49e8de1cc9e9f3226d01c4be1c3b9187583814701f703123d' ;; \
		'prometheus-3.4.1.linux-mipsle.tar.gz') sha256='af3026c3dcceeb703242f04c462a609ce291141d7fe0dea4765a8c6d6f398fc6' ;; \
		'prometheus-3.4.1.linux-ppc64.tar.gz') sha256='08d69f8057d6baa895bf0b7e3454954ff9eb37e43fbe4bfeb8b5089f4facf614' ;; \
		'prometheus-3.4.1.linux-ppc64le.tar.gz') sha256='82dea56504c3113c3417715c613b76c65bd62cf0ead67bdd88a1b9cbe7bfb638' ;; \
		'prometheus-3.4.1.linux-riscv64.tar.gz') sha256='863e1f401d32c017a1350f46d1c83aa4aba68d4a3878d07c5c64dc4b6f8c3ef5' ;; \
		'prometheus-3.4.1.linux-s390x.tar.gz') sha256='fce660b4a2a09fe47ca761ab2ba592a7fb35317ec959db60ed1932e36fed9734' ;; \
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
