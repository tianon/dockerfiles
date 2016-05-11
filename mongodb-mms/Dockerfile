FROM debian:jessie

RUN apt-get update && apt-get install -y wget logrotate && rm -rf /var/lib/apt/lists/*

ENV MMS_VERSION 4.2.0.263-1

# see https://mms.mongodb.com/settings/monitoring-agent
# click on "Ubuntu 12.04+"
RUN wget -O mms.deb "https://cloud.mongodb.com/download/agent/monitoring/mongodb-mms-monitoring-agent_${MMS_VERSION}_$(dpkg --print-architecture).ubuntu1604.deb" \
	&& dpkg -i mms.deb \
	&& rm mms.deb

# missing dep in mms.deb
RUN apt-get update && apt-get install -y libsasl2-2 && rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

USER mongodb-mms-agent
CMD ["mongodb-mms-monitoring-agent", "-conf", "/etc/mongodb-mms/monitoring-agent.config"]
