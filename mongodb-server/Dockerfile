FROM debian:unstable

RUN apt-get update && apt-get install -yq mongodb-server

# we need stdout logging and binding on 0.0.0.0
RUN sed -i ' \
		s/^logpath/#logpath/g; \
		s/^bind_ip.*$/bind_ip = 0.0.0.0/g \
	' /etc/mongodb.conf

VOLUME /var/lib/mongodb
CMD ["mongod", "--config", "/etc/mongodb.conf"]
EXPOSE 27017
