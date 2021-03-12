FROM debian:bullseye-slim

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
		fonts-dejavu \
		fonts-noto-color-emoji \
		libgl1 \
		libgl1-mesa-dri \
		libpulse0 \
	; \
	rm -rf /var/lib/apt/lists/*

# https://www.microsoftedgeinsider.com/en-us/download/?platform=linux-deb

RUN set -eux; \
	savedAptMark="$(apt-mark showmanual)"; \
	apt-get update; \
	apt-get install -y --no-install-recommends gnupg dirmngr; \
	rm -rf /var/lib/apt/lists/*; \
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys BC528686B50D79E339D3721CEB3E94ADBE1229CF; \
	gpg --batch --export --armor BC528686B50D79E339D3721CEB3E94ADBE1229CF > /etc/apt/trusted.gpg.d/microsoft.gpg.asc; \
	gpgconf --kill all; \
	rm -rf "$GNUPGHOME"; \
	apt-mark auto '.*' > /dev/null; \
	apt-mark manual $savedAptMark > /dev/null; \
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	\
# TODO non-amd64? 👀
# https://packages.microsoft.com/repos/edge/dists/stable/main/
	echo 'deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main' > /etc/apt/sources.list.d/microsoft-edge.list; \
	apt-get update; \
	rm -rf /var/lib/apt/lists/*

# https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-dev/
ENV EDGE_VERSION 90.0.818.6-1

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		"microsoft-edge-dev=$EDGE_VERSION" \
	; \
	rm -rf /var/lib/apt/lists/*; \
	microsoft-edge-dev --version

CMD ["microsoft-edge"]
