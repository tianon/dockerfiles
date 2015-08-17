FROM debian:jessie

RUN useradd --create-home user

RUN apt-get update && apt-get install -y ca-certificates --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN set -x \
	&& apt-get update && apt-get install -y curl --no-install-recommends && rm -rf /var/lib/apt/lists/* \
	&& curl -fSL "http://build.syncthing.net/job/syncthing-cli/lastSuccessfulBuild/artifact/syncthing-cli-linux-amd64.tar.gz" -O \
	&& apt-get purge -y --auto-remove curl \
	&& tar -xvf syncthing-cli-linux-amd64.tar.gz syncthing-cli-linux-amd64/syncthing-cli --strip-components=1 \
	&& mv syncthing-cli /usr/local/bin/syncthing-cli \
	&& rm syncthing-cli-linux-amd64.tar.gz

USER user
CMD ["syncthing-cli"]
