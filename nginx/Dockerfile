FROM debian:wheezy

RUN apt-get update && apt-get install -y curl

RUN curl http://nginx.org/keys/nginx_signing.key | apt-key add -
RUN echo 'deb http://nginx.org/packages/debian/ wheezy nginx' > /etc/apt/sources.list.d/nginx.list

RUN apt-get update && apt-get install -y nginx

# log to stderr
RUN sed -ri 's!\berror_log\s+\S*\b!error_log stderr!' /etc/nginx/nginx.conf && echo '\n# prevent backgrounding (for Docker)\ndaemon off;' >> /etc/nginx/nginx.conf

EXPOSE 80
CMD [ "nginx" ]
