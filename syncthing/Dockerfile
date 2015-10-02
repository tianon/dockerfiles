FROM debian:jessie

RUN useradd --create-home user

RUN apt-get update && apt-get install -y ca-certificates --no-install-recommends && rm -rf /var/lib/apt/lists/*

# gpg: key 00654A3E: public key "Syncthing Release Management <release@syncthing.net>" imported
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys 37C84554E7E0A261E4F76E1ED26E6ED000654A3E

ENV SYNCTHING_VERSION 0.11.26

RUN set -x \
	&& apt-get update && apt-get install -y curl --no-install-recommends && rm -rf /var/lib/apt/lists/* \
	&& tarball="syncthing-linux-amd64-v${SYNCTHING_VERSION}.tar.gz" \
	&& curl -fSL "https://github.com/syncthing/syncthing/releases/download/v${SYNCTHING_VERSION}/"{"$tarball",sha1sum.txt.asc} -O \
	&& apt-get purge -y --auto-remove curl \
	&& gpg --verify sha1sum.txt.asc \
	&& grep -E " ${tarball}\$" sha1sum.txt.asc | sha1sum -c - \
	&& rm sha1sum.txt.asc \
	&& tar -xvf "$tarball" --strip-components=1 "$(basename "$tarball" .tar.gz)"/syncthing \
	&& mv syncthing /usr/local/bin/syncthing \
	&& rm "$tarball"

USER user
CMD ["syncthing"]
