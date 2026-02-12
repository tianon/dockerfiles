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
ENV ALERTMANAGER_VERSION 0.31.1

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
		'alertmanager-0.31.1.linux-386.tar.gz') sha256='a9ece1d75f2f910c5ab5da0ab5d1c5e7444ce8902547e500ae5ea0f01592790e' ;; \
		'alertmanager-0.31.1.linux-amd64.tar.gz') sha256='35191cbd9d4f8162458b78dd7e93990cccd246044d9a6f788adb1c66ac3ea07b' ;; \
		'alertmanager-0.31.1.linux-arm64.tar.gz') sha256='266dda88b64318c27847ef9af4ff450fc178c827550a8039420c5ca8657a4a8b' ;; \
		'alertmanager-0.31.1.linux-armv5.tar.gz') sha256='c6ff2e054b8155aa942420e97d37a3580ee5a282e0df3a38ce6cebee7eadd51f' ;; \
		'alertmanager-0.31.1.linux-armv6.tar.gz') sha256='1728841f68b845dfabb8a4369d33a9afb24bd9a5e9480830e0022b6bf69c15b6' ;; \
		'alertmanager-0.31.1.linux-armv7.tar.gz') sha256='553db369f6266c47b9f5f2259d9fa3e1b765ea2f9dae91c877bad96d441f8643' ;; \
		'alertmanager-0.31.1.linux-mips.tar.gz') sha256='48eba0cf15bf62f59ce9a431efefaa061d8bc5c4b232e30cbb048c7c90eac796' ;; \
		'alertmanager-0.31.1.linux-mips64.tar.gz') sha256='289283ebbd5c4aefb72b5dbfdce55fc07a0c467cc37c8af3b9d8127fbe6ac8d5' ;; \
		'alertmanager-0.31.1.linux-mips64le.tar.gz') sha256='2d21fc77f41d98bd2ca0316461f91a2781149f40cbdd8fce92d6ed72aeb8afbb' ;; \
		'alertmanager-0.31.1.linux-mipsle.tar.gz') sha256='1882a0a7a2a709aeb77f96849a3e6e88716359119de5e2408335cfe49249fcfd' ;; \
		'alertmanager-0.31.1.linux-ppc64.tar.gz') sha256='2d627e4782896a8227430b273704ac57f011f15ad586e1e77e332d2c7dea53f3' ;; \
		'alertmanager-0.31.1.linux-ppc64le.tar.gz') sha256='acec8f83000749b2c74fc77a0e5ce1da75d4daadfc1ff4e29ef584a2341927ae' ;; \
		'alertmanager-0.31.1.linux-riscv64.tar.gz') sha256='e2821a586edbeb31e9d814172cc57106948168c6d49bb09e9aeef75fa55ba752' ;; \
		'alertmanager-0.31.1.linux-s390x.tar.gz') sha256='ea6b1e7e170982ebd6870e0cfce4790d222130c358ff317fb7c6c944acd9ba23' ;; \
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
