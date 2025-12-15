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
ENV ALERTMANAGER_VERSION 0.30.0

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
		'alertmanager-0.30.0.linux-386.tar.gz') sha256='4587ad2bfd3535202eabe2d55e1902d85b9561ccde783c514abdd6f3d16ebae6' ;; \
		'alertmanager-0.30.0.linux-amd64.tar.gz') sha256='86fd95034e3e17094d6951118c54b396200be22a1c16af787e1f7129ebce8f1f' ;; \
		'alertmanager-0.30.0.linux-arm64.tar.gz') sha256='061a5ab3998fb8af75192980a559c7bfa3892da55098da839d7a79d94abe0b61' ;; \
		'alertmanager-0.30.0.linux-armv5.tar.gz') sha256='8752610f8e824ee236d5b572362c792f704c5db8de8b9f334a02b02bcda50aaf' ;; \
		'alertmanager-0.30.0.linux-armv6.tar.gz') sha256='d112ed9a978d099e5774cc41353880fc881ce8ad5b5bcb8376c05c26f5da71f1' ;; \
		'alertmanager-0.30.0.linux-armv7.tar.gz') sha256='0bc19b50dd78452be2b744a67c5a8d08cd7d7411ec7f65e8c6ff1dcef7ab59f7' ;; \
		'alertmanager-0.30.0.linux-mips.tar.gz') sha256='892b64547f5836b193305f90a369f7966f4392779eb67577b51b9148ee5e1549' ;; \
		'alertmanager-0.30.0.linux-mips64.tar.gz') sha256='a05efa02f8662e236fd9eb90a4d421a09098d9826796771523e4b8ebb4ec04f9' ;; \
		'alertmanager-0.30.0.linux-mips64le.tar.gz') sha256='4af4c61c15832ec2c42bcc941cb75d20a140e72d392bbe2bb0aa9bb05a656681' ;; \
		'alertmanager-0.30.0.linux-mipsle.tar.gz') sha256='7a7eb3e03e5490ef81579f3efbba84da7bd73cd8302ef174bc69c83f756a3aa7' ;; \
		'alertmanager-0.30.0.linux-ppc64.tar.gz') sha256='9dbc7749284b1738305d609dd644a9ded3c72e8187e83053ecd51f28b5b23bd8' ;; \
		'alertmanager-0.30.0.linux-ppc64le.tar.gz') sha256='b58fd5e0781700a66dff8892a53454a7eab222f9d61da7e77ab1b3d8d178e1aa' ;; \
		'alertmanager-0.30.0.linux-riscv64.tar.gz') sha256='3fe78b78065e95a3a0a50d7c0ae593a15aa8967d72e0cff1684acdb0d50eda2c' ;; \
		'alertmanager-0.30.0.linux-s390x.tar.gz') sha256='e32981c04b83d432913d52aab4bacf599d30fec49753a970ec7026ea7148eeab' ;; \
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
