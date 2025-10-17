#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.22

RUN apk add --no-cache bash ca-certificates

WORKDIR /opt/prometheus
ENV PATH /opt/prometheus:$PATH

# https://github.com/prometheus/prometheus/releases
ENV PROMETHEUS_VERSION 3.7.1

RUN set -ex; \
	\
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		aarch64) promArch='arm64'   ;; \
		armhf)   promArch='armv6'   ;; \
		armv7)   promArch='armv7'   ;; \
		ppc64le) promArch='ppc64le' ;; \
		riscv64) promArch='riscv64' ;; \
		s390x)   promArch='s390x'   ;; \
		x86)     promArch='386'     ;; \
		x86_64)  promArch='amd64'   ;; \
		*) echo >&2 "error: unsupported arch: $apkArch"; exit 1 ;; \
	esac; \
	\
	filename="prometheus-${PROMETHEUS_VERSION}.linux-${promArch}.tar.gz"; \
	case "$filename" in \
		'prometheus-3.7.1.linux-386.tar.gz') sha256='38191d6700770098e57cdf4f00b9038ceb8855c812e4c083d37b5965ff999916' ;; \
		'prometheus-3.7.1.linux-amd64.tar.gz') sha256='a2e8a89c09b14b2277e6151e87fc8ed18858486cbf89372656d71fcd666b51da' ;; \
		'prometheus-3.7.1.linux-arm64.tar.gz') sha256='7ede3f3f0541b9bfd2ccca9cef57af80554f131b8e7af8900896c6e49ed2d4ef' ;; \
		'prometheus-3.7.1.linux-armv5.tar.gz') sha256='61b1c43c80f83c2d862c38f18a22f44cdadea5626ca459efa265077c71f34dcf' ;; \
		'prometheus-3.7.1.linux-armv6.tar.gz') sha256='388aa4f6e2b093adbd5f7250383ecd32a0e5e557a35ed69284bac7228f543c59' ;; \
		'prometheus-3.7.1.linux-armv7.tar.gz') sha256='49a739c66eb321d70f458f444cb862e0dcd285a9e1010848d2fcdbecdcb11de9' ;; \
		'prometheus-3.7.1.linux-mips.tar.gz') sha256='8b2d4ade0c59049954b8c00eaf26fca3ff28078b5bb7350e57bfce6303f0b3a2' ;; \
		'prometheus-3.7.1.linux-mips64.tar.gz') sha256='d679e58b80e9415bb66d978fad7a56d7c86601d4de14335cb3f1d8197e7b67d0' ;; \
		'prometheus-3.7.1.linux-mips64le.tar.gz') sha256='f23ee2362156a2807e93727e71de88c41246f2630b6db35088e927c8b2dd3dbe' ;; \
		'prometheus-3.7.1.linux-mipsle.tar.gz') sha256='6220dc654ea382692ae81fbbe17acf21f109ce188770627241416c79b20c1f58' ;; \
		'prometheus-3.7.1.linux-ppc64.tar.gz') sha256='1c738040f2a40ef626f7c3476570b761a5d6308d4147f66303fccadccd877d59' ;; \
		'prometheus-3.7.1.linux-ppc64le.tar.gz') sha256='bda5e25f112f79949423b37cccd4472c4a7649bc897f5142270413426199996a' ;; \
		'prometheus-3.7.1.linux-riscv64.tar.gz') sha256='7075d21f79c548b94555dcb9558a109ebcc82c3c1bf141e198ac43ca396e77ce' ;; \
		'prometheus-3.7.1.linux-s390x.tar.gz') sha256='0b751893d20c26138a0ddf1e1e2ab7275f6238c37306eb7a94df0bd38f3d4b98' ;; \
		*) echo >&2 "error: unknown file: $filename"; exit 1 ;; \
	esac; \
	wget -O /tmp/prom.tar.gz "https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/$filename"; \
	echo "$sha256 */tmp/prom.tar.gz" | sha256sum -c -; \
	\
	tar \
		--extract \
		--file /tmp/prom.tar.gz \
		--strip-components 1 \
		--verbose \
	; \
	rm /tmp/prom.tar.gz; \
	\
	prometheus --version

VOLUME /opt/prometheus/data
EXPOSE 9090

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD []
