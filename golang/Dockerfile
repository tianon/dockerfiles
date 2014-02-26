FROM	debian:stable

RUN	apt-get update && apt-get install -yq build-essential curl

RUN	curl -s https://go.googlecode.com/files/go1.2.src.tar.gz \
	| tar -v -C /usr/local -xz
ENV	PATH	/usr/local/go/bin:$PATH

ENV	GOLANG_CROSSPLATFORMS	\
	darwin/386 darwin/amd64 \
	freebsd/386 freebsd/amd64 freebsd/arm \
	linux/386 linux/amd64 linux/arm \
	windows/386 windows/amd64
# (set an explicit GOARM of 5 for maximum ARM compatibility)
ENV	GOARM	5
RUN	cd /usr/local/go/src \
	&& bash -xc '\
		for platform in $GOLANG_CROSSPLATFORMS; do \
			GOOS=${platform%/*} \
			GOARCH=${platform##*/} \
			./make.bash --no-clean 2>&1; \
		done \
	'

RUN	mkdir -p /go/src
ENV	GOPATH	/go
WORKDIR	/go
