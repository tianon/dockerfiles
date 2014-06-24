FROM debian:wheezy

# necessary for building Go
RUN apt-get update && apt-get install -y build-essential curl

# these are useful for "go get"
RUN apt-get update && apt-get install -y bzr git mercurial

RUN curl -sSL http://golang.org/dl/go1.3.src.tar.gz \
	| tar -v -C /usr/src -xz
WORKDIR /usr/src/go

# see http://golang.org/doc/install/source#environment
ENV GOLANG_CROSSPLATFORMS \
	darwin/386 darwin/amd64 \
	dragonfly/386 dragonfly/amd64 \
	freebsd/386 freebsd/amd64 freebsd/arm \
	linux/386 linux/amd64 linux/arm \
	nacl/386 nacl/amd64p32 \
	netbsd/386 netbsd/amd64 netbsd/arm \
	openbsd/386 openbsd/amd64 \
	plan9/386 plan9/amd64 \
	solaris/amd64 \
	windows/386 windows/amd64

# (set an explicit GOARM of 5 for maximum ARM compatibility)
ENV GOARM 5

RUN bash -xec '\
		cd src; \
		for platform in $GOLANG_CROSSPLATFORMS; do \
			GOOS=${platform%/*} \
			GOARCH=${platform##*/} \
			./make.bash --no-clean 2>&1; \
		done \
	'

ENV PATH /usr/src/go/bin:$PATH

RUN mkdir -p /go/src
ENV GOPATH /go
ENV PATH /go/bin:$PATH
WORKDIR /go
