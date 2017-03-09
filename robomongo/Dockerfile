FROM debian:jessie

RUN apt-get update && apt-get install -yq curl

# install dependencies...
RUN apt-get update && apt-get install -yq \
	libglib2.0-0 \
	libgl1-mesa-swx11 \
	libqt5gui5

ENV ROBOMONGO_VERSION 0.8.5

RUN mkdir /usr/share/applications && \
	curl -L "http://app.robomongo.org/files/linux/robomongo-${ROBOMONGO_VERSION}-x86_64.deb" -o /robomongo.deb && \
	{ dpkg -i /robomongo.deb || apt-get install -yq -f ;} && \
	rm /robomongo.deb || true

CMD [ "robomongo" ]
