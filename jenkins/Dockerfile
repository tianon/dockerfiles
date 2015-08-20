FROM debian:jessie

#RUN groupadd user && useradd --create-home --home-dir /home/user -g user user

RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 150FDE3F7787E7D11EF4E12A9B7D32F2D50582E6
RUN echo 'deb http://pkg.jenkins-ci.org/debian binary/' > /etc/apt/sources.list.d/jenkins.list

ENV JENKINS_VERSION 1.625

RUN apt-get update && apt-get install -y --no-install-recommends \
		jenkins=${JENKINS_VERSION} \
	&& rm -rf /var/lib/apt/lists/*

ENV JENKINS_HOME /var/lib/jenkins
RUN mkdir -p "$JENKINS_HOME" && chown -R jenkins:jenkins "$JENKINS_HOME"
VOLUME $JENKINS_HOME

EXPOSE 8080
USER jenkins
CMD ["java", "-jar", "/usr/share/jenkins/jenkins.war"]
