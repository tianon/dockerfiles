FROM debian:jessie

RUN useradd --create-home user

RUN apt-get update && apt-get install -y ca-certificates --no-install-recommends && rm -rf /var/lib/apt/lists/*

# gpg: key BCE524C7: public key "Jakob Borg (calmh) <jakob@nym.se>" imported
RUN gpg --keyserver pgp.mit.edu --recv-keys 9DCC29A8312F5C0F2625E76E49F5AEC0BCE524C7

ENV SYNCTHING_VERSION 0.10.14

RUN set -x \
	&& apt-get update && apt-get install -y curl --no-install-recommends && rm -rf /var/lib/apt/lists/* \
	&& tarball="syncthing-linux-amd64-v${SYNCTHING_VERSION}.tar.gz" \
	&& curl -SL "https://github.com/syncthing/syncthing/releases/download/v${SYNCTHING_VERSION}/"{"$tarball",sha1sum.txt.asc} -O \
	&& apt-get purge -y --auto-remove curl \
	&& gpg --verify sha1sum.txt.asc \
	&& grep -E " ${tarball}\$" sha1sum.txt.asc | sha1sum -c - \
	&& rm sha1sum.txt.asc \
	&& tar -xvf "$tarball" --strip-components=1 "$(basename "$tarball" .tar.gz)"/syncthing \
	&& mv syncthing /usr/local/bin/syncthing \
	&& rm "$tarball"

USER user
CMD ["syncthing"]
