#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.22

RUN apk add --no-cache bash ca-certificates

WORKDIR /opt/alertmanager
ENV PATH /opt/alertmanager:$PATH

# https://github.com/prometheus/alertmanager/releases
ENV ALERTMANAGER_VERSION 0.28.1

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
		'alertmanager-0.28.1.linux-386.tar.gz') sha256='86d755edb5d26d26172355d2f83b1f19d10268d3df3cdedad9ff8335a392d917' ;; \
		'alertmanager-0.28.1.linux-amd64.tar.gz') sha256='5ac7ab5e4b8ee5ce4d8fb0988f9cb275efcc3f181b4b408179fafee121693311' ;; \
		'alertmanager-0.28.1.linux-arm64.tar.gz') sha256='d8832540e5b9f613d2fd759e31d603173b9c61cc7bb5e3bc7ae2f12038b1ce4f' ;; \
		'alertmanager-0.28.1.linux-armv5.tar.gz') sha256='c0dd897cb39ce5d6701eb1c32f816154ba83f91ae1d8a7f0840276ba5739360e' ;; \
		'alertmanager-0.28.1.linux-armv6.tar.gz') sha256='5878a78343450aa39c489cfd764f407b35b9d24161aeca86ae402a66bf8e4d9c' ;; \
		'alertmanager-0.28.1.linux-armv7.tar.gz') sha256='2953e93c4f9ce5c63b19f64abc0cb175a5936a7302fd34acb2f87fd331d72387' ;; \
		'alertmanager-0.28.1.linux-mips.tar.gz') sha256='b172583d60026ee7446ec2faa8d86264a3cac33012dc960339b0a11fd651269c' ;; \
		'alertmanager-0.28.1.linux-mips64.tar.gz') sha256='85e55198bdb971f2ada16fa93df2919a0282d7fa028ac333c8f12665ba4a67ce' ;; \
		'alertmanager-0.28.1.linux-mips64le.tar.gz') sha256='030c68998289174d8ad96d4b9b0bd4eea724ef933df1c4e8cac138ca3ef95d63' ;; \
		'alertmanager-0.28.1.linux-mipsle.tar.gz') sha256='47e52375f1a09ca7226f066b7659ae7107f3c23e4c27bd234826d5d1dd101596' ;; \
		'alertmanager-0.28.1.linux-ppc64.tar.gz') sha256='432738710d1e5c40af0e9b8bdc8e2e5f10860c8898d80db790a360287d96cda4' ;; \
		'alertmanager-0.28.1.linux-ppc64le.tar.gz') sha256='9ac0c94d5f9fa4ef2e0a2a5116c7aff7f769b2cc7efe8165edf40782acc49811' ;; \
		'alertmanager-0.28.1.linux-riscv64.tar.gz') sha256='dd489361415d619b34cd670a85f099697297a42dee22acbd0285ccd0406c54e4' ;; \
		'alertmanager-0.28.1.linux-s390x.tar.gz') sha256='4e185ca997718218b7c5811c959bc0ba68b19582828b71b7653c791bb9be59ed' ;; \
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
