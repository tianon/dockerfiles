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
ENV ALERTMANAGER_VERSION 0.31.0

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
		'alertmanager-0.31.0.linux-386.tar.gz') sha256='a337f500ce3c988e1da88bf099b5df6a63e2064861cd90d55865b630f4cfeb2c' ;; \
		'alertmanager-0.31.0.linux-amd64.tar.gz') sha256='74fc59f4cb6bb2f17b72bbd23e18e067d558fa4529f0ee43603e26b8f495cede' ;; \
		'alertmanager-0.31.0.linux-arm64.tar.gz') sha256='662d5e8795d6245614c651d2015bc638e61fff1258d93e0e455cea51b52a18c3' ;; \
		'alertmanager-0.31.0.linux-armv5.tar.gz') sha256='992ea927612208846d3aedb43afb0ca0059bbc2c234794524380476347983c8d' ;; \
		'alertmanager-0.31.0.linux-armv6.tar.gz') sha256='55bbac98539113fad12d684d526df86388a8ac09badd113bacfbf1220bc3e0ee' ;; \
		'alertmanager-0.31.0.linux-armv7.tar.gz') sha256='fe7607061bf389a6df1e37bdc52191ab1c756e448305e7d189bf38799d393f84' ;; \
		'alertmanager-0.31.0.linux-mips.tar.gz') sha256='32d22ccd992cdb50e2139171f18aa009dedb48fcca90b0f7f3d2cb8de80d3ccb' ;; \
		'alertmanager-0.31.0.linux-mips64.tar.gz') sha256='1415dc12ae4d0b6c8285d75b21182d73fb080cabdbcd7ec4ee3bbb3a390c8e07' ;; \
		'alertmanager-0.31.0.linux-mips64le.tar.gz') sha256='f5e8904c60dbc5adb5c8d544cb5e4b2997b029ddb4d090a36d7e92f9d50928e9' ;; \
		'alertmanager-0.31.0.linux-mipsle.tar.gz') sha256='3aba906d41cce18afcad8963545b6c5037abe691ddc4ddcbf8f4c483406d234b' ;; \
		'alertmanager-0.31.0.linux-ppc64.tar.gz') sha256='31e1c234ac4273673bbb89b682ee4323766346e613dd6c876c0a7ccb4bbfaf8c' ;; \
		'alertmanager-0.31.0.linux-ppc64le.tar.gz') sha256='0def669f52b0db42304932b057f54db7871850e4ba38d412914d48161d552f77' ;; \
		'alertmanager-0.31.0.linux-riscv64.tar.gz') sha256='72db0241ffb940069526b95a6bccf2118bf885f1d1c692e8712848a13eb3b108' ;; \
		'alertmanager-0.31.0.linux-s390x.tar.gz') sha256='19842e40b275333bd6f7e51bc8fddfd1e756c73d417eea737dccdd1d9f9824da' ;; \
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
