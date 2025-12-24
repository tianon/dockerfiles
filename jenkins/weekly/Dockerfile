#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:trixie-slim

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates curl \
		gnupg \
		gosu tini \
		\
		git openssh-client \
		\
# java.lang.UnsatisfiedLinkError: /opt/java/openjdk/lib/libfontmanager.so: libfreetype.so.6: cannot open shared object file: No such file or directory
		fontconfig \
	; \
	apt-get dist-clean

# https://www.jenkins.io/doc/administration/requirements/java/ ("Jenkins requires Java 11 or 17 since Jenkins 2.357 and LTS 2.361.1.")
ENV JAVA_HOME /opt/java/openjdk
COPY --from=eclipse-temurin:17-jre $JAVA_HOME $JAVA_HOME
ENV PATH $JAVA_HOME/bin:$PATH
RUN set -eux; \
	if \
		LD_LIBRARY_PATH="$JAVA_HOME/lib:$JAVA_HOME/lib/server${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}" \
			find "$JAVA_HOME" -type f '(' -executable -o -name '*.so' ')' -exec ldd '{}' + \
			| grep -vE 'libX[A-Za-z0-9]+|libasound' \
			| grep 'not found' \
	; then \
		exit 1; \
	fi; \
	java --version

# https://pkg.jenkins.io/debian/
ENV JENKINS_GPG_KEY 5E386EADB55F01504CAE8BCF7198F4B714ABFC68
RUN set -eux; \
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "$JENKINS_GPG_KEY"; \
	gpg --batch --export --armor "$JENKINS_GPG_KEY" > /etc/apt/keyrings/jenkins.gpg.asc; \
	gpgconf --kill all; \
	rm -rf "$GNUPGHOME"

RUN echo 'deb [ signed-by=/etc/apt/keyrings/jenkins.gpg.asc ] https://pkg.jenkins.io/debian binary/' > /etc/apt/sources.list.d/jenkins.list

ENV JENKINS_VERSION 2.543

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		jenkins="$JENKINS_VERSION" \
	; \
	apt-get dist-clean; \
	java -jar /usr/share/java/jenkins.war --version

ENV JENKINS_HOME /var/lib/jenkins
RUN mkdir -p "$JENKINS_HOME" && chown -R jenkins:jenkins "$JENKINS_HOME"
VOLUME $JENKINS_HOME

EXPOSE 8080
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["jenkins"]
