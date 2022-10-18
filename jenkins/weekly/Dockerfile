#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:bullseye-slim

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates curl \
		gnupg dirmngr \
		gosu tini \
		\
		git openssh-client \
	; \
	rm -rf /var/lib/apt/lists/*

# https://groups.google.com/d/msg/jenkins-infra/c7m_72vUTXE/37zw9GXhAQAJ
ENV JENKINS_GPG_KEY 62A9756BFD780C377CF24BA8FCEF32E745F2C3D5
RUN set -eux; \
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "$JENKINS_GPG_KEY"; \
	gpg --batch --export --armor "$JENKINS_GPG_KEY" > /etc/apt/trusted.gpg.d/jenkins.gpg.asc; \
	gpgconf --kill all; \
	rm -rf "$GNUPGHOME"; \
	apt-key list

# TODO use signed-by
RUN echo 'deb https://pkg.jenkins.io/debian binary/' > /etc/apt/sources.list.d/jenkins.list

ENV JENKINS_VERSION 2.374

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		jenkins="$JENKINS_VERSION" \
		default-jre-headless \
	; \
	rm -rf /var/lib/apt/lists/*; \
	java -jar /usr/share/java/jenkins.war --version

ENV JENKINS_HOME /var/lib/jenkins
RUN mkdir -p "$JENKINS_HOME" && chown -R jenkins:jenkins "$JENKINS_HOME"
VOLUME $JENKINS_HOME

EXPOSE 8080
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["java", "-jar", "/usr/share/jenkins/jenkins.war"]
