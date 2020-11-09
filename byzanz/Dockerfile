FROM debian:buster-slim

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		byzanz \
	; \
	rm -rf /var/lib/apt/lists/*

CMD ["byzanz-record"]
