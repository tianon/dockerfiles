#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:trixie-slim

# https://github.com/deskflow/deskflow/releases
ENV DESKFLOW_VERSION 1.27.0

RUN set -eux; \
	savedAptMark="$(apt-mark showmanual)"; \
	apt-get update; \
	apt-get install -y --no-install-recommends ca-certificates wget; \
	apt-mark auto '.*' > /dev/null; \
	[ -z "$savedAptMark" ] || apt-mark manual $savedAptMark > /dev/null; \
	\
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'arm64') url='https://github.com/deskflow/deskflow/releases/download/v1.27.0/deskflow-1.27.0-debian-trixie-aarch64.deb'; sha256='4780856cca83dc8bcead0495584301d4f83f87f53341bdf447f0915b7b15c596' ;; \
		'amd64') url='https://github.com/deskflow/deskflow/releases/download/v1.27.0/deskflow-1.27.0-debian-trixie-x86_64.deb'; sha256='1f7de2f1fbc68de410339dbdb11ed0e5439bd49bfbfbf66f4467def1c6bb5f96' ;; \
		*) echo >&2 "error: unsupported architecture: '$dpkgArch'"; exit 1 ;; \
	esac; \
	\
	wget -O deskflow.deb "$url"; \
	echo "$sha256 *deskflow.deb" | sha256sum --strict --check -; \
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	\
	apt-get install -y ./deskflow.deb; \
	rm deskflow.deb; \
	\
	apt-get dist-clean

CMD ["deskflow"]
