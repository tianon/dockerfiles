FROM debian:wheezy

RUN apt-get update && apt-get install -y curl logrotate

ENV MMS_VERSION 2.9.0.164-1

# see https://mms.mongodb.com/settings/monitoring-agent
# click on "Ubuntu 12.04+"
RUN curl -sSL https://mms.mongodb.com/download/agent/monitoring/mongodb-mms-monitoring-agent_${MMS_VERSION}_amd64.deb -o mms.deb \
	&& dpkg -i mms.deb \
	&& rm mms.deb

ADD docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

USER mongodb-mms-agent
CMD ["mongodb-mms-monitoring-agent", "-conf", "/etc/mongodb-mms/monitoring-agent.config"]
