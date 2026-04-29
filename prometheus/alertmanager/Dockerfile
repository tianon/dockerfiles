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
ENV ALERTMANAGER_VERSION 0.32.1

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
		'alertmanager-0.32.1.linux-386.tar.gz') sha256='24a99bcc3e7a6fc29e01656c69749c873f15597e6556a18058aa5837afb96b0c' ;; \
		'alertmanager-0.32.1.linux-amd64.tar.gz') sha256='e3ba4a543111dd4bbf436838385cbf88108f0b128a723e61fe97d3569294ad4d' ;; \
		'alertmanager-0.32.1.linux-arm64.tar.gz') sha256='fff322eae493eabdec5c16dfdfb26b37508aaf3ca3238ab1ed1e5bebf3ff4cd9' ;; \
		'alertmanager-0.32.1.linux-armv5.tar.gz') sha256='a1dd148205da01bd485f03584bba21f7b616b60cf1484276f6ec954aa7911bd6' ;; \
		'alertmanager-0.32.1.linux-armv6.tar.gz') sha256='81ac656b0378dbb9efe3bfbd378a9a37137151b9665a7b0415bd03d3f971927b' ;; \
		'alertmanager-0.32.1.linux-armv7.tar.gz') sha256='ff43b8f48208855a156722a0993e07e1059e3bd4687908c7c73e3cdd8647678f' ;; \
		'alertmanager-0.32.1.linux-mips.tar.gz') sha256='47593fe74d9a4b4c4d45613f0075e9e25b1b642106175e5aea22c3f3748344d3' ;; \
		'alertmanager-0.32.1.linux-mips64.tar.gz') sha256='1d956fb24e0dbcdc05bb6157b8b7f88e1b159466e12ef0a39ff18589f4c9d418' ;; \
		'alertmanager-0.32.1.linux-mips64le.tar.gz') sha256='f4365edba77c8822aa66d4cc78643a9716715338a85325bba91d07dab47ce15b' ;; \
		'alertmanager-0.32.1.linux-mipsle.tar.gz') sha256='819b3e035de86da5dacd25f291db0d1a21a343db3fe558fced872a22da5e9ff7' ;; \
		'alertmanager-0.32.1.linux-ppc64.tar.gz') sha256='ce5b4631974f0cc1ca411b43cdc0f887fb754de35362a0f376af1f952338a6ae' ;; \
		'alertmanager-0.32.1.linux-ppc64le.tar.gz') sha256='57799eb5a7ad8b91d92feaaf30c9d6f52b52e5aae408c9c5616b198f39af773b' ;; \
		'alertmanager-0.32.1.linux-riscv64.tar.gz') sha256='3704825876fd9f3e13c29658e05186097765d0bfe96759b26e5e6835f246ade4' ;; \
		'alertmanager-0.32.1.linux-s390x.tar.gz') sha256='8410d78c05a1c4a469e63722c7602e874fbaf06e2d35f125a09ebf9576f1e0ae' ;; \
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
