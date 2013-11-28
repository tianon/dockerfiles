FROM tianon/debian:wheezy

RUN apt-get update && apt-get install -yq curl python-pymongo python-setuptools

RUN curl https://mms.mongodb.com/settings/mms-monitoring-agent.tar.gz | tar -xz
WORKDIR /mms-agent

ADD entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["python", "agent.py"]
