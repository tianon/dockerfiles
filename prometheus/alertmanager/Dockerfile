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
ENV ALERTMANAGER_VERSION 0.35.1

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
		'alertmanager-0.35.1.linux-386.tar.gz') sha256='38b06a4230e2189b5f78c76f66af260214d42a303eeb455731e4c649acc35bc7' ;; \
		'alertmanager-0.35.1.linux-amd64.tar.gz') sha256='626bb9ae4486e14044705a6d6a0394f2ad8e3bf40df918f18f15b3d3775aa069' ;; \
		'alertmanager-0.35.1.linux-arm64.tar.gz') sha256='780c75de6941bcb31f2663679d190c9b62a714f5de5fb1e449213b4240e1279c' ;; \
		'alertmanager-0.35.1.linux-armv5.tar.gz') sha256='6ef66f6c770b4fc83707de100cdda3bf263ddb4f035c4dda06984bfd1d6622d1' ;; \
		'alertmanager-0.35.1.linux-armv6.tar.gz') sha256='4032d956cd17c256e5f6ecc80269c68b866f83ef9249c4c25b08759e3b193491' ;; \
		'alertmanager-0.35.1.linux-armv7.tar.gz') sha256='9c2335ff767430a3e4b00d262c713f16f914ccc202495e241e60bae55c63053f' ;; \
		'alertmanager-0.35.1.linux-mips.tar.gz') sha256='fdce9e151e56915b80c641f43698a7cd71646d95f701bcea274371d9d0a56e72' ;; \
		'alertmanager-0.35.1.linux-mips64.tar.gz') sha256='aa6e062898390dfd96e44b931caf50a0b84a077739fff1abf89ac1b87ec57d9c' ;; \
		'alertmanager-0.35.1.linux-mips64le.tar.gz') sha256='eb47b666b71a3eb2eafdcf148916c677f25e2cf77e82ace9dfc0f6cc378bfacb' ;; \
		'alertmanager-0.35.1.linux-mipsle.tar.gz') sha256='eec13585a48e9fc9d7048768ef37d3fc99ccc03fa72dd8ca40671a607cd9d3a5' ;; \
		'alertmanager-0.35.1.linux-ppc64.tar.gz') sha256='30c7a671574ba7e1589a2b8e335fba2a6c8859cc90594d6d79f0e21a89bb1534' ;; \
		'alertmanager-0.35.1.linux-ppc64le.tar.gz') sha256='e4eae92ea40404c337a41bbeeb7af43b6fc1b091f9b5f571ba1afb8c9a8e9014' ;; \
		'alertmanager-0.35.1.linux-riscv64.tar.gz') sha256='56af94d3352e3c22ca2bf7432fcdea3076eba538a9769ccfa97f226fcd6b4c80' ;; \
		'alertmanager-0.35.1.linux-s390x.tar.gz') sha256='152a0f5ef77d382f77431bae25dba15a80b44da08193a3b201cb92f247ab02ad' ;; \
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
