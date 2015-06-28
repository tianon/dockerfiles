FROM tianon/qemu

RUN apt-get update && apt-get install -y --no-install-recommends \
		autopkgtest \
		vmdebootstrap \
	&& rm -rf /var/lib/apt/lists/*

CMD ["vmdebootstrap"]
