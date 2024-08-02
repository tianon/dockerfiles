#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.20

# https://www.speedtest.net/apps/cli#download
ENV SPEEDTEST_VERSION 1.2.0

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		'x86') url='https://install.speedtest.net/app/cli/ookla-speedtest-1.2.0-linux-i386.tgz' ;; \
		'x86_64') url='https://install.speedtest.net/app/cli/ookla-speedtest-1.2.0-linux-x86_64.tgz' ;; \
		'armhf') url='https://install.speedtest.net/app/cli/ookla-speedtest-1.2.0-linux-armhf.tgz' ;; \
		'armv7') url='https://install.speedtest.net/app/cli/ookla-speedtest-1.2.0-linux-armhf.tgz' ;; \
		'aarch64') url='https://install.speedtest.net/app/cli/ookla-speedtest-1.2.0-linux-aarch64.tgz' ;; \
		*) echo >&2 "error: unknown/unsupported architecture: '$apkArch' (see https://www.speedtest.net/apps/cli#download)"; exit 1 ;; \
	esac; \
	wget -O speedtest.tgz "$url"; \
	tar -xvf speedtest.tgz -C /usr/local/bin speedtest; \
	rm speedtest.tgz; \
	speedtest --version

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["speedtest"]
