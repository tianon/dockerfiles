FROM alpine:3.11

# https://www.speedtest.net/apps/cli#download
ENV SPEEDTEST_VERSION 1.0.0

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		x86_64 | aarch64 | armhf) ooklaArch="$apkArch" ;; \
# TODO verify that ookla's "armhf" really is armv6
		armv7) ooklaArch='armhf' ;; \
		x86) ooklaArch='i386' ;; \
# TODO figure out what ookla means by their bare "arm" arch
		*) echo >&2 "error: unknown/unsupported architecture: $apkArch (see https://www.speedtest.net/apps/cli#download)"; exit 1 ;; \
	esac; \
	wget -O speedtest.tgz "https://bintray.com/ookla/download/download_file?file_path=ookla-speedtest-$SPEEDTEST_VERSION-$ooklaArch-linux.tgz"; \
	tar -xvf speedtest.tgz -C /usr/local/bin speedtest; \
	rm speedtest.tgz; \
	speedtest --version

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["speedtest"]
