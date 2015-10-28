FROM java:7-jre

WORKDIR /usr/local/kafka
ENV PATH $PATH:/usr/local/kafka/bin

# https://kafka.apache.org/downloads.html
ENV KAFKA_VERSION 0.8.2.2
ENV SCALA_VERSION 2.10

RUN curl -fSL "http://apache.osuosl.org/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz" | tar -xz --strip-components=1

RUN sed -i 's!^zookeeper.connect=.*!zookeeper.connect=zookeeper:2181!' config/server.properties

CMD ["kafka-server-start.sh", "config/server.properties"]
