FROM tianon/ruby-unicorn

RUN apt-get update && apt-get install -yq nginx

# I wish there were a nice clean way to have nginx spawn unicorn itself
RUN apt-get update && apt-get install -yq supervisor

# configure nginx
RUN rm /etc/nginx/sites-enabled/default
ADD nginx-unicorn.conf /etc/nginx/sites-enabled/unicorn
# log to stderr and stay foregrounded
RUN sed -ri 's!\berror_log\s+\S*\b!error_log stderr!' /etc/nginx/nginx.conf && echo '\n# prevent backgrounding (for Docker)\ndaemon off;' >> /etc/nginx/nginx.conf

# configure unicorn
ADD unicorn.conf.rb /apps/unicorn/unicorn.conf.rb

# configure supervisor
RUN echo '[supervisord]\nnodaemon=true' > /etc/supervisor/conf.d/no-daemon.conf && \
	echo '[program:nginx]\ncommand=nginx\nstdout_logfile=/dev/stdout\nredirect_stderr=true' > /etc/supervisor/conf.d/nginx.conf && \
	echo '[program:unicorn]\ncommand=unicorn --config-file /apps/unicorn/unicorn.conf.rb\nstdout_logfile=/dev/stdout\nredirect_stderr=true' > /etc/supervisor/conf.d/unicorn.conf

CMD ["supervisord", "-n"]
