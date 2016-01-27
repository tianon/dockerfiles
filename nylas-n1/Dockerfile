FROM buildpack-deps:jessie-curl

RUN apt-get update && apt-get install -y zenity && rm -rf /var/lib/apt/lists/*

# hijack the browser in the worst way possible
RUN dpkg-divert --local --rename /usr/bin/xdg-open \
	&& { \
		echo '#!/bin/bash'; \
		echo 'set -e'; \
		echo 'exec &> /proc/1/fd/1'; \
		echo 'echo'; \
		echo 'echo --- WEB BROWSER ---'; \
		echo 'echo'; \
		echo 'echo "  $@"'; \
		echo 'echo'; \
		echo 'echo'; \
	} > /usr/bin/xdg-open \
	&& chmod +x /usr/bin/xdg-open

ENV N1_VERSION 0.3.45

RUN curl -fSL "https://github.com/nylas/N1/releases/download/$N1_VERSION/N1-$N1_VERSION.deb" -o n1.deb \
	&& dpkg --unpack n1.deb \
	&& rm n1.deb \
	&& apt-get update && apt-get install -yf && rm -rf /var/lib/apt/lists/*

CMD ["/usr/share/nylas/nylas"]
