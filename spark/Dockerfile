FROM java:7-jre

WORKDIR /usr/local/spark
ENV PATH $PATH:/usr/local/spark/bin

ENV SPARK_VERSION 1.5.1
 
RUN curl -fSL "http://apache.osuosl.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-without-hadoop.tgz" | tar -xz --strip-components=1
