FROM debian:stable

RUN echo 'APT::Default-Release "stable";' > /etc/apt/apt.conf.d/default

RUN for suite in oldstable testing unstable experimental; do \
		echo "deb http://deb.debian.org/debian $suite main" > /etc/apt/sources.list.d/$suite.list; \
	done && apt-get update
