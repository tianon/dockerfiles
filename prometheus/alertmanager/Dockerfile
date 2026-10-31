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
ENV ALERTMANAGER_VERSION 0.34.2

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
		'alertmanager-0.34.2.linux-386.tar.gz') sha256='a77c8c223bd106bed0f3841e9d0a95f3a3c89d4de9913c413e854b70acea386b' ;; \
		'alertmanager-0.34.2.linux-amd64.tar.gz') sha256='17ee14acd0f6ba6e25a436ff223d9c17ddd5cf484f543ad12f0932eaa89ba186' ;; \
		'alertmanager-0.34.2.linux-arm64.tar.gz') sha256='5aaad82e3d167c30c06ce7d38677d2892a6f66f4c3613ea17af7481750fdd0b0' ;; \
		'alertmanager-0.34.2.linux-armv5.tar.gz') sha256='9dc7607408f178b6fe1fa987a7970a723c274fe00dd61ce171c2e15de324157b' ;; \
		'alertmanager-0.34.2.linux-armv6.tar.gz') sha256='63eef4d56d3933dd5bafc6aeec622bdd8a31aabbf0fecfeaa7f14b1d8be28a3e' ;; \
		'alertmanager-0.34.2.linux-armv7.tar.gz') sha256='ef98293019465aacb6020b8437e6863f799e9c3d170e5777e6298092408d28fc' ;; \
		'alertmanager-0.34.2.linux-mips.tar.gz') sha256='ca6f15e16bf4cb9a3a5dcb75ba009a3ee3bfa2c399f352fe573ee9895bf33c20' ;; \
		'alertmanager-0.34.2.linux-mips64.tar.gz') sha256='1535296208ed3a9db473973609eb76789a04b2c21f12603d189a12a3314a0cb6' ;; \
		'alertmanager-0.34.2.linux-mips64le.tar.gz') sha256='a6e70f85746cabe7eb0c554faaecfc46100a9d728f34cfefdd1d58fd6a802c0c' ;; \
		'alertmanager-0.34.2.linux-mipsle.tar.gz') sha256='944f5a71533753295e27041725c7013525e0c8956e614e0fbcf40de4e96a2352' ;; \
		'alertmanager-0.34.2.linux-ppc64.tar.gz') sha256='4adafe9484713df91484673816c4fea337c88bcb95288097a3a45ae7b3a83956' ;; \
		'alertmanager-0.34.2.linux-ppc64le.tar.gz') sha256='03eef987364573626269fb47559f3213fc0059240c07c7fcc6323bc867fda973' ;; \
		'alertmanager-0.34.2.linux-riscv64.tar.gz') sha256='4aeae738d4ceb1c5bf45b9e4ee77139fcea51fb08b1b9103994aa4582c371e02' ;; \
		'alertmanager-0.34.2.linux-s390x.tar.gz') sha256='b2c610fce727cacf451c1db19a9a01227f51b7a187f30c9f712ca63fab177da2' ;; \
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
