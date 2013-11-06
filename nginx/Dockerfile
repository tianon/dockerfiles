FROM tianon/debian:wheezy

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yq curl
RUN curl http://nginx.org/keys/nginx_signing.key | apt-key add -
RUN echo 'deb http://nginx.org/packages/debian/ wheezy nginx' > /etc/apt/sources.list.d/nginx.list
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yq nginx

# log to stderr
RUN sed -ri 's!\berror_log\s+\S*\b!error_log stderr!' /etc/nginx/nginx.conf && echo '\n# prevent backgrounding (for Docker)\ndaemon off;' >> /etc/nginx/nginx.conf

VOLUME /usr/share/nginx/html
EXPOSE 80

CMD [ "nginx" ]
