FROM java:8-jre

# https://ehour.nl/download/downloadfile.php?get=ehour-latest-standalone-unix.sh
# https://ehour.nl/download/downloadfile.php?get=ehour-1.4.3-standalone-unix.sh
ENV EHOUR_VERSION 1.4.3
ENV EHOUR_URL https://ehour.nl/download/downloadfile.php?get=ehour-${EHOUR_VERSION}-standalone-unix.sh

RUN wget -O ehour.sh "$EHOUR_URL" \
	&& chmod +x ehour.sh

RUN { echo 'o'; echo ''; } | ./ehour.sh

WORKDIR /usr/local/ehour

RUN wget -O fresh.mysql.sql 'https://github.com/te-con/ehour/raw/20150227-RELEASE-1.4.3/eHour-persistence-mysql/src/sql/install/fresh.mysql.sql'

RUN set -ex \
	&& for prop in log4j ehour; do \
		cp home/conf/$prop.properties home/conf/$prop.properties.orig; \
	done
COPY *.properties home/conf/

EXPOSE 8000

CMD ["./ehour", "start-launchd"]
