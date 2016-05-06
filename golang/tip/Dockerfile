FROM buildpack-deps:jessie-scm

# gcc for cgo
RUN apt-get update && apt-get install -y --no-install-recommends \
		g++ \
		gcc \
		libc6-dev \
		make \
	&& rm -rf /var/lib/apt/lists/*

ENV GOLANG_REPO https://github.com/golang/go
ENV GOLANG_BRANCH master
ENV GOLANG_COMMIT b90cb3f4716d3fede57bf8e798d27406fba5c294
ENV GOLANG_SRC_URL $GOLANG_REPO/archive/$GOLANG_COMMIT.tar.gz
ENV GOLANG_PATCH_URL $GOLANG_REPO/commit/$GOLANG_COMMIT.patch

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
	&& echo "$GOLANG_BRANCH +$(echo "$GOLANG_COMMIT" | cut -b-7) $(curl -fsSL "$GOLANG_PATCH_URL" | tac|tac | awk -F ': ' '$1 == "Date" { print $2; exit }')" > /usr/local/go/VERSION \
	&& cd /usr/local/go/src \
	&& ./make.bash \
	\
	&& rm -rf "$GOROOT_BOOTSTRAP"

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN go version

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH
