#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.22

RUN apk add --no-cache bash ca-certificates tzdata

WORKDIR /opt/alertmanager
ENV PATH /opt/alertmanager:$PATH

# https://github.com/prometheus/alertmanager/releases
ENV ALERTMANAGER_VERSION 0.29.0

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
		'alertmanager-0.29.0.linux-386.tar.gz') sha256='ae05385383bf0ae68c11c9bb36f2b9f1f5c333e7ee1eaec5c915778330e4cfc8' ;; \
		'alertmanager-0.29.0.linux-amd64.tar.gz') sha256='74e8f141d61a8157d957e2856a9861a5a923827d70e2d4abdd36276bcd66d2f3' ;; \
		'alertmanager-0.29.0.linux-arm64.tar.gz') sha256='45f4ad029cb09a77c092daa09dd064bd22932e84ce22f58fc4d043ac460204bf' ;; \
		'alertmanager-0.29.0.linux-armv5.tar.gz') sha256='abec3bf29c11a8e2ef7017e6b2272427158f695b6f3fdbc0b291468a97787c67' ;; \
		'alertmanager-0.29.0.linux-armv6.tar.gz') sha256='62dc9d34e340e18d03a23d6efc9db52b3c51d31dd39191720ad9ef8c27c5aaa2' ;; \
		'alertmanager-0.29.0.linux-armv7.tar.gz') sha256='1d5943d51b045b1b958405f11c6810371e37d42b92e1e8d22e762040d02919ad' ;; \
		'alertmanager-0.29.0.linux-mips.tar.gz') sha256='0a31b6b6af2ab817fba823d9c3f41ca86e85b3cd77fd95cce4ba6a06bde03d89' ;; \
		'alertmanager-0.29.0.linux-mips64.tar.gz') sha256='c39be2c1ec511bdcea9bd68687f466c3ff34349c3271c968aa8b9ca0f03e9f6d' ;; \
		'alertmanager-0.29.0.linux-mips64le.tar.gz') sha256='b18766f69d5cb2ba5ff77ee4be4612874e91ae3b34fa2884565f6fab525d0bb0' ;; \
		'alertmanager-0.29.0.linux-mipsle.tar.gz') sha256='43f0415d4c645d88dfedfca3c3f572483079725faafe25c7ba9ca06aec3bc988' ;; \
		'alertmanager-0.29.0.linux-ppc64.tar.gz') sha256='1564db6579c5e2a8b10fe0b3f42ebbd8073167cb1f63447890aa082b1b7f3bc6' ;; \
		'alertmanager-0.29.0.linux-ppc64le.tar.gz') sha256='73be6e7d4dae78a72ec24921a85e442fefe20fdf6834834675de5a7110cbf6a8' ;; \
		'alertmanager-0.29.0.linux-riscv64.tar.gz') sha256='a68f27c491c3915bb9b1c88ee470d0b5bdfd0f26e8833ecfc498a800e06b660b' ;; \
		'alertmanager-0.29.0.linux-s390x.tar.gz') sha256='15207809eb0df8330c110a75e929090ca55efcc0c85762837b71082a9f86ba5f' ;; \
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
