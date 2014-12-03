FROM debian:wheezy

RUN adduser user

ENV SKYPE_URL http://download.skype.com/linux/skype-debian_4.3.0.37-1_i386.deb

RUN dpkg --add-architecture i386 \
	&& apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/* \
	&& wget "${SKYPE_URL}" -O skype.deb \
	&& apt-get purge -y --auto-remove wget \
	&& { dpkg -i skype.deb || true; } \
	&& rm skype.deb \
	&& apt-get install -y -f

USER user
VOLUME /home/user
CMD ["skype"]
