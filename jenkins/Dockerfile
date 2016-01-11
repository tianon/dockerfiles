FROM debian:jessie

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		ca-certificates curl \
		\
		git openssh-client \
	&& rm -rf /var/lib/apt/lists/*

# grab gosu for easy step-down from root
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
ENV GOSU_VERSION 1.7
RUN curl -o /usr/local/bin/gosu -fSL "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-$(dpkg --print-architecture)" \
	&& curl -o /usr/local/bin/gosu.asc -fSL "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-$(dpkg --print-architecture).asc" \
	&& gpg --verify /usr/local/bin/gosu.asc \
	&& rm /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu

RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 150FDE3F7787E7D11EF4E12A9B7D32F2D50582E6
RUN echo 'deb http://pkg.jenkins-ci.org/debian binary/' > /etc/apt/sources.list.d/jenkins.list

ENV JENKINS_VERSION 1.644

RUN apt-get update && apt-get install -y --no-install-recommends \
		jenkins=${JENKINS_VERSION} \
	&& rm -rf /var/lib/apt/lists/*

ENV JENKINS_HOME /var/lib/jenkins
RUN mkdir -p "$JENKINS_HOME" && chown -R jenkins:jenkins "$JENKINS_HOME"
VOLUME $JENKINS_HOME

EXPOSE 8080
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["java", "-jar", "/usr/share/jenkins/jenkins.war"]
