FROM debian:testing

RUN dpkg --add-architecture i386 && \
	apt-get update && \
	apt-get install -yq wine:i386
