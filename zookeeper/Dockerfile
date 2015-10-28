FROM java:7-jre

WORKDIR /usr/local/zookeeper
ENV PATH $PATH:/usr/local/zookeeper/bin

ENV ZOOKEEPER_VERSION 3.4.6

RUN curl -fSL "http://apache.osuosl.org/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/zookeeper-${ZOOKEEPER_VERSION}.tar.gz" | tar -xz --strip-components=1

RUN sed 's!^dataDir=.*!dataDir=/var/lib/zookeeper!' conf/zoo_sample.cfg > conf/zoo.cfg
VOLUME /var/lib/zookeeper

CMD ["zkServer.sh", "start-foreground"]
