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
ENV ALERTMANAGER_VERSION 0.34.0

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
		'alertmanager-0.34.0.linux-386.tar.gz') sha256='760bc24119280d38bf484eea51b4658ea4b1fec12d6ad93aad740a3899611353' ;; \
		'alertmanager-0.34.0.linux-amd64.tar.gz') sha256='19c75a11d8c03dc4ade7abdbddfb3a8f28c9e7b000d0849cda0cd71dffd74a03' ;; \
		'alertmanager-0.34.0.linux-arm64.tar.gz') sha256='a96ef16598ddc58e84d28167b3352b30e3205698d76c56ef467e4504d7664da4' ;; \
		'alertmanager-0.34.0.linux-armv5.tar.gz') sha256='bf413280ffba19abcb2f216be4075ff4ee77772eeb58492c681cd7c6b09d1f6d' ;; \
		'alertmanager-0.34.0.linux-armv6.tar.gz') sha256='3ddc65d5ba655e08de7932be91863b748d1ed47873a16a439e6d8a7bc565f146' ;; \
		'alertmanager-0.34.0.linux-armv7.tar.gz') sha256='068c2c6975f2dfaa1cb9a696d1208121f27bbba8c017280af7cc3c058ae4d9cf' ;; \
		'alertmanager-0.34.0.linux-mips.tar.gz') sha256='b5953e29ec1227ed96e611280359a435eca74884b921316cedcf1fb7217ae9fc' ;; \
		'alertmanager-0.34.0.linux-mips64.tar.gz') sha256='9f784946cc4038e202010240f43c26f3f3e653a1ceaf3a727096b8f50ad44d48' ;; \
		'alertmanager-0.34.0.linux-mips64le.tar.gz') sha256='8ca76a08d18e2dcedaf5f056e290798984987a157e0bf826851e9f09e590bc5e' ;; \
		'alertmanager-0.34.0.linux-mipsle.tar.gz') sha256='f4a7bb4469a6903d02335f8aed541ce8cd3f255dc53ead938070907b9980adff' ;; \
		'alertmanager-0.34.0.linux-ppc64.tar.gz') sha256='3f9ce6862fbe98df11cfd71e59d8dffd2ab70e69f29c402474c50689f823018f' ;; \
		'alertmanager-0.34.0.linux-ppc64le.tar.gz') sha256='ffab6c196ca8ffe18056707bb8e788927ae8c39c1847b704a1e9c4a7d81259ed' ;; \
		'alertmanager-0.34.0.linux-riscv64.tar.gz') sha256='ead28dbb2879cacbc3b2fea0b1e7e187f5e005f1eb9b796ca2f0b42004fbcbf0' ;; \
		'alertmanager-0.34.0.linux-s390x.tar.gz') sha256='6f605832c14d970f619afa8ae652c996223580fd6bb8fa6be86b9a37ea282c6d' ;; \
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
