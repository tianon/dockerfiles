FROM debian:sid

RUN dpkg --add-architecture i386 \
	&& apt-get update \
	&& apt-get install -y wine:i386
