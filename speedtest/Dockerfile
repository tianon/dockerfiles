#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.17

# https://www.speedtest.net/apps/cli#download
ENV SPEEDTEST_VERSION 1.2.0

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		x86_64 | aarch64 | armhf) ooklaArch="$apkArch" ;; \
		x86) ooklaArch='i386' ;; \
# Ookla's "armhf" is armv6 (just like Alpine's), which is fair game for ARMv7 devices
		armv7) ooklaArch='armhf' ;; \
# Ookla's "armel" arch is armv5, which Alpine doesn't support :(
		*) echo >&2 "error: unknown/unsupported architecture: '$apkArch' (see https://www.speedtest.net/apps/cli#download)"; exit 1 ;; \
	esac; \
	wget -O speedtest.tgz "https://install.speedtest.net/app/cli/ookla-speedtest-$SPEEDTEST_VERSION-linux-$ooklaArch.tgz"; \
	tar -xvf speedtest.tgz -C /usr/local/bin speedtest; \
	rm speedtest.tgz; \
	speedtest --version

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["speedtest"]
