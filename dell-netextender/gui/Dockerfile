FROM tianon/dell-netextender

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		openjdk-7-jre \
	&& rm -rf /var/lib/apt/lists

CMD ["netExtenderGui"]
