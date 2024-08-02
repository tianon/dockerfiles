#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.20

RUN apk add --no-cache ca-certificates

WORKDIR /opt/blackbox-exporter
ENV PATH /opt/blackbox-exporter:$PATH

# https://github.com/prometheus/blackbox_exporter/releases
ENV BLACKBOX_EXPORTER_VERSION 0.25.0

RUN set -ex; \
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
	filename="blackbox_exporter-${BLACKBOX_EXPORTER_VERSION}.linux-$promArch.tar.gz"; \
	case "$filename" in \
		'blackbox_exporter-0.25.0.linux-386.tar.gz') sha256='f1109e6c7c5f990ee18459bfece9092470eb4002c3ccdfaadc9b6201681f327c' ;; \
		'blackbox_exporter-0.25.0.linux-amd64.tar.gz') sha256='c651ced6405c5e0cd292a400f47ae9b34f431f16c7bb098afbcd38f710144640' ;; \
		'blackbox_exporter-0.25.0.linux-arm64.tar.gz') sha256='46ec5a54a41dc1ea8a8cecee637e117de4807d3b0976482a16596e82e79ac484' ;; \
		'blackbox_exporter-0.25.0.linux-armv5.tar.gz') sha256='43111bc49fd9623606f3a4409cf5523b1888151be957c371c544c2dcd1cd7b97' ;; \
		'blackbox_exporter-0.25.0.linux-armv6.tar.gz') sha256='dfa00330a4d1bce28bc04f26316f0636dfb628cef719fa0737e0b6cc51c53ab2' ;; \
		'blackbox_exporter-0.25.0.linux-armv7.tar.gz') sha256='4a275bf8c0b83fcac3db9afb7099b33fdc52ff267e2852a72b62f5611ab540f0' ;; \
		'blackbox_exporter-0.25.0.linux-mips.tar.gz') sha256='5f0bfe51459488066a89b92982c7209576c5f074153aa6a9d56f2fc19173e53a' ;; \
		'blackbox_exporter-0.25.0.linux-mips64.tar.gz') sha256='bc140a93bbbde69f6a5579e3e40e9e4a940985d445367685d9c3858d84ea1b6c' ;; \
		'blackbox_exporter-0.25.0.linux-mips64le.tar.gz') sha256='ea647fd081466172ab0bcc04123b437942f331bdd6304023f4116e3ae3d0fc71' ;; \
		'blackbox_exporter-0.25.0.linux-mipsle.tar.gz') sha256='a38c26c9cbb22ab853ad5017cc1db362f7a66c6ebcf1b15e62b9a5895893cd10' ;; \
		'blackbox_exporter-0.25.0.linux-ppc64.tar.gz') sha256='fd2bfdf1377309e2cf8295cb693a8cb3a85e0c4761f75d823453d47658f46285' ;; \
		'blackbox_exporter-0.25.0.linux-ppc64le.tar.gz') sha256='51cd904c8c48e0d0c1b5d3e8d26cd540c0c40f2548217aba8ae6dbe9430929ff' ;; \
		'blackbox_exporter-0.25.0.linux-riscv64.tar.gz') sha256='588670381a768b064ed99e10e54c081efa97fb6f8bbb8e59767195d7cbe524f2' ;; \
		'blackbox_exporter-0.25.0.linux-s390x.tar.gz') sha256='c22e7f17e3deab3affa8cc1ea2e475008ccf448bafc8e5808da48be174796cc7' ;; \
		*) echo >&2 "error: unknown file: $filename"; exit 1 ;; \
	esac; \
	wget -O /tmp/blackbox-exporter.tar.gz "https://github.com/prometheus/blackbox_exporter/releases/download/v${BLACKBOX_EXPORTER_VERSION}/$filename"; \
	echo "$sha256 */tmp/blackbox-exporter.tar.gz" | sha256sum -c -; \
	\
	tar \
		--extract \
		--file /tmp/blackbox-exporter.tar.gz \
		--strip-components 1 \
		--verbose \
	; \
	rm /tmp/blackbox-exporter.tar.gz; \
	\
	blackbox_exporter --version

VOLUME /opt/blackbox-exporter/data

EXPOSE 9115
CMD ["blackbox_exporter"]
