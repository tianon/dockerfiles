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
ENV ALERTMANAGER_VERSION 0.32.2

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
		'alertmanager-0.32.2.linux-386.tar.gz') sha256='6ec74e5b118ff2a00a2042ff7e72c8bed96d1ac2c33bae4460f161b39a2c4ef5' ;; \
		'alertmanager-0.32.2.linux-amd64.tar.gz') sha256='842f30671734e9920327aa8308e19aea7bb79c2b9905e941d83236267f87b13d' ;; \
		'alertmanager-0.32.2.linux-arm64.tar.gz') sha256='1f223735c43bd60d4f6d5663169b8ecbb07282751431e19a64f6afa29616b66d' ;; \
		'alertmanager-0.32.2.linux-armv5.tar.gz') sha256='87b8b5c76ce5d5d6138020f1b983b633a48847630c181a7c5bc41f40a188635e' ;; \
		'alertmanager-0.32.2.linux-armv6.tar.gz') sha256='ccd23731659c0153c602a794c76d4c487dd209f285d62e16e6ec6b1a3858b4cf' ;; \
		'alertmanager-0.32.2.linux-armv7.tar.gz') sha256='030a8e56a9a9ba372c95fba27e2beb0d285e2ae62956d4564b238d7dc460b8e2' ;; \
		'alertmanager-0.32.2.linux-mips.tar.gz') sha256='8f5e18605a2fcc8d3c49e1d74fa23acaf43253ce6119c3fd142cd8d3a67f9911' ;; \
		'alertmanager-0.32.2.linux-mips64.tar.gz') sha256='d881b205f827cf5b5b204342336936d918a3b60fc4b9e9035ac93e398199613a' ;; \
		'alertmanager-0.32.2.linux-mips64le.tar.gz') sha256='85218d20b154547c533312e27f80b835a8bfd0eca6552a319e6b6373b1373a76' ;; \
		'alertmanager-0.32.2.linux-mipsle.tar.gz') sha256='4bd766872f6adb47f67015655ea82461c3b395c164d8a0968bca60c955353a59' ;; \
		'alertmanager-0.32.2.linux-ppc64.tar.gz') sha256='185c6a5fb1ca4a74383d03be4bfdc2964829ed864b8bdefbb1f7a2323e0b382d' ;; \
		'alertmanager-0.32.2.linux-ppc64le.tar.gz') sha256='8ec9fa38740d48261342eb42aee27a2ab16f3df0f763a0b56be7d983265f62b9' ;; \
		'alertmanager-0.32.2.linux-riscv64.tar.gz') sha256='7fe5eca7662bebbbf7127a10355ff4646ac992257f0df8a5a2fa81e3da5899e7' ;; \
		'alertmanager-0.32.2.linux-s390x.tar.gz') sha256='a31798cfafe7f44c2747beedc0e62b33ece2c06e0c7bd3473eafa813a8dbb712' ;; \
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
