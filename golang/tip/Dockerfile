FROM buildpack-deps:jessie-scm

# gcc for cgo
RUN apt-get update && apt-get install -y --no-install-recommends \
		g++ \
		gcc \
		libc6-dev \
		make \
	&& rm -rf /var/lib/apt/lists/*

ENV GOLANG_BRANCH master
ENV GOLANG_COMMIT c165988360457553ccbfa4a09919de3262a4438a
ENV GOLANG_SRC_URL https://github.com/golang/go/archive/$GOLANG_COMMIT.tar.gz

ENV GOLANG_BOOTSTRAP_VERSION 1.6.2
ENV GOLANG_BOOTSTRAP_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_BOOTSTRAP_VERSION.linux-amd64.tar.gz

RUN set -ex \
	\
	&& export GOROOT_BOOTSTRAP='/usr/local/go-bootstrap' \
	&& mkdir -p "$GOROOT_BOOTSTRAP" \
	&& curl -fSL "$GOLANG_BOOTSTRAP_DOWNLOAD_URL" \
		| tar -zxC "$GOROOT_BOOTSTRAP" --strip-components=1 \
	\
	&& mkdir -p /usr/local/go \
	&& curl -fSL "$GOLANG_SRC_URL" \
		| tar -zxC /usr/local/go --strip-components=1 \
	&& echo "$GOLANG_BRANCH +$(echo "$GOLANG_COMMIT" | cut -b-7)" > /usr/local/go/VERSION \
	&& cd /usr/local/go/src \
	&& ./make.bash \
	\
	&& rm -rf "$GOROOT_BOOTSTRAP"

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH
