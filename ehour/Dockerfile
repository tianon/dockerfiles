FROM openjdk:8-jre

# https://ehour.nl/download/downloadfile.php?get=ehour-latest-standalone-unix.sh
# https://ehour.nl/download/downloadfile.php?get=ehour-1.4.3-standalone-unix.sh
ENV EHOUR_VERSION 1.4.3
ENV EHOUR_URL https://ehour.nl/download/downloadfile.php?get=ehour-${EHOUR_VERSION}-standalone-unix.sh

RUN wget -O ehour.sh "$EHOUR_URL" --progress=dot:giga \
	&& chmod +x ehour.sh

RUN { echo 'o'; echo ''; } | ./ehour.sh

WORKDIR /usr/local/ehour

ENV EHOUR_RELEASE_TAG 20150227-RELEASE-1.4.3

RUN set -xe \
	&& wget -O ehour.tar.gz "https://github.com/te-con/ehour/archive/$EHOUR_RELEASE_TAG.tar.gz" --progress=dot:giga \
	&& mkdir -p temp-tar \
	&& tar -xf ehour.tar.gz -C temp-tar --strip-components=1 \
	&& rm ehour.tar.gz \
	&& for db in mysql postgresql; do \
		mkdir -p "sql/$db"; \
		cp -R -t "sql/$db" temp-tar/"eHour-persistence-$db"/src/sql/*; \
	done \
	&& rm -r temp-tar

RUN set -ex \
	&& for prop in log4j ehour; do \
		cp home/conf/$prop.properties home/conf/$prop.properties.orig; \
	done
COPY *.properties home/conf/

EXPOSE 8000

CMD ["./ehour", "start-launchd"]
