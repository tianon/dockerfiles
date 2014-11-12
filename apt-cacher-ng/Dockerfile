FROM debian:sid

RUN apt-get update && apt-get install -y apt-cacher-ng

RUN { \
		echo 'ForeGround: 1'; \
		echo 'Port: 80'; \
	} > /etc/apt-cacher-ng/docker.conf

RUN ln -sf /dev/stdout /var/log/apt-cacher-ng/apt-cacher.out \
	&& ln -sf /dev/stderr /var/log/apt-cacher-ng/apt-cacher.err

RUN echo 'http://http.debian.net/debian/' > /etc/apt-cacher-ng/backends_debian
RUN echo 'http://archive.ubuntu.com/ubuntu/' > /etc/apt-cacher-ng/backends_ubuntu

EXPOSE 80
CMD ["apt-cacher-ng", "-c", "/etc/apt-cacher-ng"]
