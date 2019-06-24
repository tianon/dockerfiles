FROM debian:stretch-slim

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		ca-certificates curl wget \
		gnupg dirmngr \
		\
		git openssh-client \
	&& rm -rf /var/lib/apt/lists/*

# grab gosu for easy step-down from root
ENV GOSU_VERSION 1.10
RUN set -x \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
	&& wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
	&& gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
	&& gpgconf --kill all \
	&& rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true

# grab tini for signal processing and zombie killing
ENV TINI_VERSION v0.13.0
RUN set -x \
	&& wget -O /usr/local/bin/tini "https://github.com/krallin/tini/releases/download/$TINI_VERSION/tini" \
	&& wget -O /usr/local/bin/tini.asc "https://github.com/krallin/tini/releases/download/$TINI_VERSION/tini.asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys 6380DC428747F6C393FEACA59A84159D7001A4E5 \
	&& gpg --batch --verify /usr/local/bin/tini.asc /usr/local/bin/tini \
	&& gpgconf --kill all \
	&& rm -r "$GNUPGHOME" /usr/local/bin/tini.asc \
	&& chmod +x /usr/local/bin/tini \
	&& tini -h

RUN apt-get update && apt-get install -y apt-transport-https && rm -rf /var/lib/apt/lists/*

ENV JENKINS_GPG_KEY 150FDE3F7787E7D11EF4E12A9B7D32F2D50582E6
RUN export GNUPGHOME="$(mktemp -d)" \
	&& gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys "$JENKINS_GPG_KEY" \
	&& gpg --batch --export --armor "$JENKINS_GPG_KEY" > /etc/apt/trusted.gpg.d/jenkins.gpg.asc \
	&& gpgconf --kill all \
	&& rm -r "$GNUPGHOME" \
	&& apt-key list
RUN echo 'deb https://pkg.jenkins.io/debian binary/' > /etc/apt/sources.list.d/jenkins.list

ENV JENKINS_VERSION 2.182

RUN set -ex; \
# update-alternatives: error: error creating symbolic link '/usr/share/man/man1/rmid.1.gz.dpkg-tmp': No such file or directory
	mkdir -p /usr/share/man/man1; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		jenkins="$JENKINS_VERSION" \
		openjdk-8-jre-headless \
	; \
	rm -rf /var/lib/apt/lists/*

# "java.awt.AWTError: Assistive Technology not found: org.GNOME.Accessibility.AtkWrapper"
# https://askubuntu.com/a/723503
# https://bugs.debian.org/798794
RUN sed -i 's/^assistive_technologies=/#&/' /etc/java-8-openjdk/accessibility.properties

ENV JENKINS_HOME /var/lib/jenkins
RUN mkdir -p "$JENKINS_HOME" && chown -R jenkins:jenkins "$JENKINS_HOME"
VOLUME $JENKINS_HOME

EXPOSE 8080
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["java", "-jar", "/usr/share/jenkins/jenkins.war"]
