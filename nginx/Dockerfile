FROM tianon/debian:wheezy

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yq nginx

RUN echo '\n# prevent backgrounding (for Docker)\ndaemon off;' >> /etc/nginx/nginx.conf

VOLUME /usr/share/nginx/www/
EXPOSE 80

CMD [ "nginx" ]
