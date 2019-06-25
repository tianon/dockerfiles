FROM tianon/dell-netextender

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends openjdk-8-jre; \
	rm -rf /var/lib/apt/lists

CMD ["netExtenderGui"]
