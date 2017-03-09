FROM golang:1.7-alpine

# fetch dependencies
# format: import-path=strip-components=tarball-url
ENV GCPC_DEPS \
# https://github.com/coreos/go-systemd/releases
	github.com/coreos/go-systemd=1=https://github.com/coreos/go-systemd/archive/v14.tar.gz \
# https://github.com/satori/go.uuid/releases
	github.com/satori/go.uuid=1=https://github.com/satori/go.uuid/archive/v1.1.0.tar.gz \
# https://github.com/urfave/cli/releases
	github.com/urfave/cli=1=https://github.com/urfave/cli/archive/v1.19.1.tar.gz \
# https://github.com/golang/net/commits/master
	golang.org/x/net=1=https://github.com/golang/net/archive/8fd7f25.tar.gz \
# https://github.com/golang/oauth2/commits/master
	golang.org/x/oauth2=1=https://github.com/golang/oauth2/archive/314dd2c.tar.gz \
# https://bazaar.launchpad.net/~chipaca/go-xdg/v0/files ("view revision")
# https://bazaar.launchpad.net/~chipaca/go-xdg/v0/revision/10?start_revid=10 ("download tarball")
	launchpad.net/go-xdg/v0=3=https://bazaar.launchpad.net/~chipaca/go-xdg/v0/tarball/10?start_revid=10
RUN set -ex; \
	\
	apk add --no-cache --virtual .build-deps \
		openssl \
		tar \
	; \
	\
	for dep in $GCPC_DEPS; do \
		strip="${dep#*=}"; dep="${dep%=$strip}"; \
		tarball="${strip#*=}"; strip="${strip%=$tarball}"; \
		\
		wget -O dep.tar.gz "$tarball"; \
		mkdir -p "$GOPATH/src/$dep"; \
		tar -xvf dep.tar.gz --strip-components="$strip" -C "$GOPATH/src/$dep"; \
		rm dep.tar.gz; \
	done; \
	\
	apk del .build-deps

# https://github.com/google/cloud-print-connector/releases
ENV GOOGLE_CLOUD_PRINT_CONNECTOR_VERSION v1.1
#ENV GOOGLE_CLOUD_PRINT_CONNECTOR_VERSION d353d01
# https://github.com/google/cloud-print-connector/commit/d353d01
ENV GCPC_IMPORT github.com/google/cloud-print-connector

RUN set -ex; \
	\
	apk add --no-cache --virtual .build-deps \
		avahi-dev \
		cups-dev \
		gcc \
		libc-dev \
		\
		openssl \
		tar \
	; \
	\
	wget -O gcpc.tar.gz "https://$GCPC_IMPORT/archive/$GOOGLE_CLOUD_PRINT_CONNECTOR_VERSION.tar.gz"; \
	mkdir -p "$GOPATH/src/$GCPC_IMPORT"; \
	tar -xvf gcpc.tar.gz --strip-components=1 -C "$GOPATH/src/$GCPC_IMPORT"; \
	rm gcpc.tar.gz; \
	\
	go install -v \
		-ldflags "-X $GCPC_IMPORT/lib.BuildDate=$GOOGLE_CLOUD_PRINT_CONNECTOR_VERSION" \
		"$GCPC_IMPORT/..." \
	; \
	\
	runDeps="$( \
		scanelf --needed --nobanner --recursive "$GOPATH/bin" \
			| awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
			| sort -u \
			| xargs -r apk info --installed \
			| sort -u \
	)"; \
	apk add --virtual .gcpc-rundeps $runDeps; \
	\
	apk del .build-deps; \
	\
	gcp-cups-connector --version
