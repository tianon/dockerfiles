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
ENV PROMETHEUS_VERSION 2.47.0

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
		'prometheus-2.47.0.linux-386.tar.gz') sha256='ef482503c13f45972f3388fa20c311d167a871030d2a2e32560a999f0d6dc284' ;; \
		'prometheus-2.47.0.linux-amd64.tar.gz') sha256='277ad9f110ded8e326bc885848952941e839fa38dd3237e36415f0fa35a04424' ;; \
		'prometheus-2.47.0.linux-arm64.tar.gz') sha256='243f8203a2906f0077ae4b7498b406cc03d5b6c96743ce48e590f71a2eb590a7' ;; \
		'prometheus-2.47.0.linux-armv5.tar.gz') sha256='1117e97e45e7dd8d32cccdda51462ae173e0fe4b8d53ca5fe4207640f93cf972' ;; \
		'prometheus-2.47.0.linux-armv6.tar.gz') sha256='f60cb6a7583c01dbf0b9c22147140b8b0a1f284b3d7cfa167b3e1c1906815a20' ;; \
		'prometheus-2.47.0.linux-armv7.tar.gz') sha256='035e3b61c7dcda7ccd14e587f1d21382a4c0a6092e1d48a7f485b2eb9474357f' ;; \
		'prometheus-2.47.0.linux-mips.tar.gz') sha256='7903382913489219ccf381de840050276029a274bfe3388623173dadf78efa5f' ;; \
		'prometheus-2.47.0.linux-mips64.tar.gz') sha256='fd7e98551433178d27975e1220a136751dcfbbf9f923323daca3e9a54e3c6520' ;; \
		'prometheus-2.47.0.linux-mips64le.tar.gz') sha256='a3478abb2cb2847a10479f07d8b3aab8ce27962904cb8db43b822dac41fd98ed' ;; \
		'prometheus-2.47.0.linux-mipsle.tar.gz') sha256='3c8d42b72f4778a6eaecfae3f1f6eded673af83f0842c93458d0136d20680d62' ;; \
		'prometheus-2.47.0.linux-ppc64.tar.gz') sha256='1eca7fb85840b987db5bea3d8d4d72a88ee9c3a59b38421b4a3a3f4984037d5f' ;; \
		'prometheus-2.47.0.linux-ppc64le.tar.gz') sha256='b54200fbfb8fb5d59a23d8cd876556d1a6daa370d14be6e2fb4638b5a7a7bea7' ;; \
		'prometheus-2.47.0.linux-riscv64.tar.gz') sha256='9fbb6ac64f06d3d7902c9b3a213ad8c5a4dc67aef943b4cc15220d6046ba51ef' ;; \
		'prometheus-2.47.0.linux-s390x.tar.gz') sha256='5008f1830c45ea0ed239cbf1a795214096d8b9817caac658f5bc0bb93a890a08' ;; \
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
