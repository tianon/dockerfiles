#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.18

RUN apk add --no-cache bash ca-certificates

WORKDIR /opt/prometheus
ENV PATH /opt/prometheus:$PATH

# https://github.com/prometheus/prometheus/releases
ENV PROMETHEUS_VERSION 2.49.1

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
	filename="prometheus-${PROMETHEUS_VERSION}.linux-${promArch}.tar.gz"; \
	case "$filename" in \
		'prometheus-2.49.1.linux-386.tar.gz') sha256='c71ffc608a75fb023b6dd052c1e38f78b855d59b96d0d4201d06e0314c4d14c4' ;; \
		'prometheus-2.49.1.linux-amd64.tar.gz') sha256='93460f66d17ee70df899e91db350d9705c20b1576800f96acbd78fa004e7dc07' ;; \
		'prometheus-2.49.1.linux-arm64.tar.gz') sha256='453c530f17e899999a0ba34b5556b14a14061c22520edaac84b3376d28942664' ;; \
		'prometheus-2.49.1.linux-armv5.tar.gz') sha256='2b57952f59a0cac5bdf02d29e17c0978452fa86703284aa4f91d79633a88774a' ;; \
		'prometheus-2.49.1.linux-armv6.tar.gz') sha256='04454bab6575ddcb2a12ff9c1819fa154185cc10d59ba477c2295e4afaef8dad' ;; \
		'prometheus-2.49.1.linux-armv7.tar.gz') sha256='938f5e8e8bd285501610f73ba5d164222b688ac8308a98da96fa929d69e16272' ;; \
		'prometheus-2.49.1.linux-mips.tar.gz') sha256='ae9729eebbc7eea7248e3ff6bf554222d9206bf05af257a2ce53eb7a0cdfc4f1' ;; \
		'prometheus-2.49.1.linux-mips64.tar.gz') sha256='a6a52e8807c19f143758e602052183f4ffd279fb756be075a71887a42291febf' ;; \
		'prometheus-2.49.1.linux-mips64le.tar.gz') sha256='5627c3acd3517faf17b7242103e38e6aff05e0ef68be9c709ddf90896e6d23a9' ;; \
		'prometheus-2.49.1.linux-mipsle.tar.gz') sha256='7a4dc08da9e399e3db7265396b220e4c93fd337f89b42b57060a97146a5d4a98' ;; \
		'prometheus-2.49.1.linux-ppc64.tar.gz') sha256='f6afaa5588173921ebec80eebf029571a7d846f92610cdbc4c5b3e8a907b521a' ;; \
		'prometheus-2.49.1.linux-ppc64le.tar.gz') sha256='1905eb0218ab8988e1f67215034698f685252a0ebc36d9b25c77a57790bb6a62' ;; \
		'prometheus-2.49.1.linux-riscv64.tar.gz') sha256='0c19d55c88e9d319aab5d96d666d57089fc7bf05dec697677c3063f46c3c3796' ;; \
		'prometheus-2.49.1.linux-s390x.tar.gz') sha256='3df60c424bb635d640caa993d92326eb89b010f57d3b023deac97b5fb699dbdf' ;; \
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
