FROM tianon/dell-netextender

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends default-jre; \
	rm -rf /var/lib/apt/lists

CMD ["netExtenderGui"]
