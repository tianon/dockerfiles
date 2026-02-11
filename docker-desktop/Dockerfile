#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

#
# HUGE CAVEAT:
#
#   This is nowhere near a supported way to run Docker Desktop.
#   This is a huge ugly hack that barely works for the way I play with it.
#

FROM rust:1.89-slim-trixie AS virtiofsd

RUN set -eux; \
	apt-get install --update -y --no-install-recommends \
		libcap-ng-dev \
		libseccomp-dev \
		patch \
		wget ca-certificates \
	; \
	apt-get dist-clean

WORKDIR /virtiofsd

# see the end of this Dockerfile -- this version needs to match what's shipped with the relevant version of Docker Desktop
ENV VIRTIOFS_VERSION 1.11.1
# https://gitlab.com/virtio-fs/virtiofsd/-/tags

RUN set -eux; \
	wget -O virtiofsd.tar.gz "https://gitlab.com/virtio-fs/virtiofsd/-/archive/v${VIRTIOFS_VERSION}/virtiofsd-v${VIRTIOFS_VERSION}.tar.gz"; \
	tar -xvf virtiofsd.tar.gz --strip-components=1; \
	rm virtiofsd.tar.gz

# it appears that the DD builds apply https://gitlab.com/virtio-fs/virtiofsd/-/merge_requests/237 👀 ("error: unexpected argument '--translate-uid' found")
COPY virtiofsd-237.patch ./
RUN patch --strip=1 --input=virtiofsd-237.patch

COPY virtiofsd.patch ./
RUN patch --strip=1 --input=virtiofsd.patch

RUN cargo build --release

# https://docs.docker.com/desktop/linux/
FROM debian:trixie-slim

# https://docs.docker.com/desktop/release-notes/
# https://docs.docker.com/desktop/linux/install/
ENV DOCKER_DESKTOP_VERSION 4.60.1

RUN set -eux; \
	apt-get install --update -y --no-install-recommends \
		ca-certificates \
# https://docs.docker.com/desktop/linux/#credentials-management
		pass \
	; \
	savedAptMark="$(apt-mark showmanual)"; \
	apt-get install -y --no-install-recommends \
		gnupg \
		wget \
	; \
	apt-mark auto '.*' > /dev/null; \
	apt-mark manual $savedAptMark > /dev/null; \
	\
	GNUPGHOME="$(mktemp -d)"; export GNUPGHOME; \
	gpg --keyserver keyserver.ubuntu.com --recv-keys 9DC858229FC7DD38854AE2D88D81803C0EBFCD88; \
	mkdir -p /usr/local/share/keyrings; \
	gpg --export --armor 9DC858229FC7DD38854AE2D88D81803C0EBFCD88 > /usr/local/share/keyrings/docker-archive.gpg.asc; \
	gpgconf --kill all; \
	rm -rf "$GNUPGHOME"; \
	\
	. /etc/os-release; \
	dpkgArch="$(dpkg --print-architecture)"; \
	echo "deb [ arch=$dpkgArch signed-by=/usr/local/share/keyrings/docker-archive.gpg.asc ] https://download.docker.com/linux/debian $VERSION_CODENAME stable" > /etc/apt/sources.list.d/docker.list; \
	apt-get update; \
	\
	case "$dpkgArch" in \
		'amd64') url='https://desktop.docker.com/linux/main/amd64/218372/docker-desktop-amd64.deb'; sha256='51a1c21095bed8364acc41aa3626c4233b0dbedbfd5f4fa138fd183e0fa1066b' ;; \
		'arm64') url='https://desktop.docker.com/linux/main/arm64/218372/docker-desktop-arm64.deb'; sha256='494bfe654be353405031657da9cd617a5f71a357c4a4c9e307ead059c3fb43d3' ;; \
		*) echo >&2 "error: unsupported architecture: '$dpkgArch'"; exit 1 ;; \
	esac; \
	\
	wget -O docker-desktop.deb --progress=dot:giga "$url"; \
	echo "$sha256 *docker-desktop.deb" | sha256sum --strict --check -; \
	\
	apt-get install -y --no-install-recommends ./docker-desktop.deb; \
	rm docker-desktop.deb; \
	\
# yay, missing Depends again!
	apt-get install -y --no-install-recommends \
		libdrm2 \
		libgbm1 \
	; \
	\
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	apt-get dist-clean
# smoke test
RUN set -eux; \
	find /opt/docker-desktop -type f -executable -exec bash -Eeuo pipefail -xc 'ldd "$@" || :' -- '{}' + > /tmp/ldd.txt; \
	if grep 'not found' /tmp/ldd.txt; then exit 1; fi; \
	rm /tmp/ldd.txt

ENV PATH /opt/docker-desktop/bin:$PATH

# virtiofsd defaults to "--sandbox=namespace" (which doesn't work well in a container) and "--sandbox=chroot" or "--sandbox=none" are only allowed for root, so I provide a patched build of virtiofsd (matching the version that ships with Docker Desktop)
COPY --from=virtiofsd /virtiofsd/target/release/virtiofsd /opt/docker-desktop/bin/virtiofsd.tianon
RUN set -eux; \
	virtiofsd="$(command -v virtiofsd)"; \
	[ "$virtiofsd" = '/opt/docker-desktop/bin/virtiofsd' ]; \
	\
	before="$(virtiofsd --version 2>&1)"; \
	dpkg-divert --add --rename --divert /opt/docker-desktop/bin/virtiofsd.orig /opt/docker-desktop/bin/virtiofsd; \
	ln -svfT virtiofsd.tianon /opt/docker-desktop/bin/virtiofsd; \
	after="$(virtiofsd --version 2>&1)"; \
	[ "$before" = "$after" ]; \
	\
# explicitly divert QEMU's "virtiofsd" to make sure it doesn't get installed/used accidentally (in trixie it moved from qemu-system-common to a dedicated virtiofsd package, which is good)
	[ ! -s /usr/lib/qemu/virtiofsd ]; \
	[ ! -s /usr/libexec/virtiofsd ]; \
	dpkg-divert --add --rename --divert /usr/lib/qemu/virtiofsd.orig /usr/lib/qemu/virtiofsd; \
	dpkg-divert --add --rename --divert /usr/libexec/virtiofsd.orig /usr/libexec/virtiofsd

RUN set -eux; \
# setting up ID maps for virtiofsd namespace: retrieving subordinate UID range: no range for <USER> found in /etc/subuid
	echo '1000:100000:65536' > /etc/subuid; \
	echo '1000:100000:65536' > /etc/subgid; \
# newuidmap: write to uid_map failed: Operation not permitted
	ln -svfT /bin/true /usr/local/bin/newuidmap; \
	ln -svfT /bin/true /usr/local/bin/newgidmap
# TODO come up with something less ... hacky?

#CMD ["docker-desktop"]
# TODO CMD ["com.docker.backend", "--with-frontend"]
# this broke and "com.docker.backend" does not like being run from PATH anymore
# [com.docker.backend] monitor exited: fork/exec /docker-desktop-home/com.docker.backend: no such file or directory
CMD ["/opt/docker-desktop/bin/com.docker.backend", "--with-frontend"]
