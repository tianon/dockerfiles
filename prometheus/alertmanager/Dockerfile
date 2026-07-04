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
ENV ALERTMANAGER_VERSION 0.33.1

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
		'alertmanager-0.33.1.linux-386.tar.gz') sha256='682fec480f92d8aaec7aeb3569e19015128a266f44035ab0d73f1e1279750f0c' ;; \
		'alertmanager-0.33.1.linux-amd64.tar.gz') sha256='93d802cba6a8d27239d747ce117df7648d326ab67394e32247540b030e9842ba' ;; \
		'alertmanager-0.33.1.linux-arm64.tar.gz') sha256='50b32a346c3c29da411643dfa84990440e8fd03800380d7e664f22a863b7a0cf' ;; \
		'alertmanager-0.33.1.linux-armv5.tar.gz') sha256='773aba04640262688570d096aca5c4cc5b9df7ba8ee247893e5a97f692c79309' ;; \
		'alertmanager-0.33.1.linux-armv6.tar.gz') sha256='501a9d975927396e38817d3809a2572bd7ce17574b4d088cda6e8201e0765fe9' ;; \
		'alertmanager-0.33.1.linux-armv7.tar.gz') sha256='da07515616e05ee30a8bae2e23de67f520fb7f92080d962cd8d0e4c2ddacfd6e' ;; \
		'alertmanager-0.33.1.linux-mips.tar.gz') sha256='1b206c2cad2eec6ce930f3c0700a5bf2d96cd44f429a1906e1e5aae100a4f0bc' ;; \
		'alertmanager-0.33.1.linux-mips64.tar.gz') sha256='ed1324916a9f9b5383c588ad67d9745f8fb5e1987603e6d2c6663f768bbe34e3' ;; \
		'alertmanager-0.33.1.linux-mips64le.tar.gz') sha256='42640c0ba901289ea8810cb361d71207f81226688aa36ad232f123fd80664006' ;; \
		'alertmanager-0.33.1.linux-mipsle.tar.gz') sha256='c505b0240c4bb7374475f442acf1ad8621f14c897b01c12b889bea1acc98a3b0' ;; \
		'alertmanager-0.33.1.linux-ppc64.tar.gz') sha256='7dfd6d55b6af62e7c150b212e0f35c09c53067f25d3dfbd01b208e441486d204' ;; \
		'alertmanager-0.33.1.linux-ppc64le.tar.gz') sha256='d3b16b875cc17776371ab725d218093559cbd8cf9a2765e42205936a1b5af817' ;; \
		'alertmanager-0.33.1.linux-riscv64.tar.gz') sha256='aaac8c7f916cfb50852d124c6cd2c8f5205cc9e0d3317fc3e9165221fa74a827' ;; \
		'alertmanager-0.33.1.linux-s390x.tar.gz') sha256='4ab801fa2161dbec22667941a09145c4d079a7720d165b64c3b7c5f5ec21ca71' ;; \
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
