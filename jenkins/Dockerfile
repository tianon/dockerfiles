FROM debian:buster-slim

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates curl wget \
		gnupg dirmngr \
		\
		git openssh-client \
	; \
	rm -rf /var/lib/apt/lists/*

# grab gosu for easy step-down from root
ENV GOSU_VERSION 1.11
# grab tini for signal processing and zombie killing
ENV TINI_VERSION 0.18.0
RUN set -eux; \
	\
	dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
	wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch"; \
	wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc"; \
	wget -O /usr/local/bin/tini "https://github.com/krallin/tini/releases/download/v$TINI_VERSION/tini-$dpkgArch"; \
	wget -O /usr/local/bin/tini.asc "https://github.com/krallin/tini/releases/download/v$TINI_VERSION/tini-$dpkgArch.asc"; \
	\
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4; \
	gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu; \
	gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys 6380DC428747F6C393FEACA59A84159D7001A4E5; \
	gpg --batch --verify /usr/local/bin/tini.asc /usr/local/bin/tini; \
	gpgconf --kill all; \
	rm -rf "$GNUPGHOME" /usr/local/bin/gosu.asc /usr/local/bin/tini.asc; \
	\
	chmod +x /usr/local/bin/gosu /usr/local/bin/tini; \
	gosu --version; \
	gosu nobody true; \
	tini -h

# https://groups.google.com/d/msg/jenkins-infra/c7m_72vUTXE/37zw9GXhAQAJ
ENV JENKINS_GPG_KEY 62A9756BFD780C377CF24BA8FCEF32E745F2C3D5
RUN set -eux; \
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys "$JENKINS_GPG_KEY"; \
	gpg --batch --export --armor "$JENKINS_GPG_KEY" > /etc/apt/trusted.gpg.d/jenkins.gpg.asc; \
	gpgconf --kill all; \
	rm -rf "$GNUPGHOME"; \
	apt-key list

RUN echo 'deb https://pkg.jenkins.io/debian binary/' > /etc/apt/sources.list.d/jenkins.list

ENV JENKINS_VERSION 2.238

RUN set -ex; \
# update-alternatives: error: error creating symbolic link '/usr/share/man/man1/rmid.1.gz.dpkg-tmp': No such file or directory
	mkdir -p /usr/share/man/man1; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		jenkins="$JENKINS_VERSION" \
		default-jre-headless \
	; \
	rm -rf /var/lib/apt/lists/*

ENV JENKINS_HOME /var/lib/jenkins
RUN mkdir -p "$JENKINS_HOME" && chown -R jenkins:jenkins "$JENKINS_HOME"
VOLUME $JENKINS_HOME

EXPOSE 8080
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["java", "-jar", "/usr/share/jenkins/jenkins.war"]
