FROM php:5.6-apache

RUN apt-get update && apt-get install -y --no-install-recommends \
		libmcrypt-dev \
		xz-utils \
	&& rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install mbstring mcrypt mysqli
RUN pecl install uploadprogress && docker-php-ext-enable uploadprogress

# https://docs.phpmyadmin.net/en/latest/setup.html#verifying-phpmyadmin-releases
ENV GPG_KEYS \
# Since July 2015 all phpMyAdmin releases are cryptographically signed by the releasing developer, who through January 2016 was Marc Delisle.
	436FF1884B1A0C3FDCBF0D79FEFC65D181AF644A \
# Beginning in January 2016, the release manager is Isaac Bennetch.
	3D06A59ECE730EB71B511C17CE752F178259BD92 \
# Some additional downloads (for example themes) might be signed by Michal Čihař.
	63CB1DF1EF12CF2AC0EE5A329C27B31342B7511D

RUN set -ex; \
	for key in $GPG_KEYS; do \
		gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
	done

ENV PHPMYADMIN_VERSION 4.6.6

RUN set -x \
	&& curl -fsSL "https://files.phpmyadmin.net/phpMyAdmin/${PHPMYADMIN_VERSION}/phpMyAdmin-${PHPMYADMIN_VERSION}-english.tar.xz" -o phpmyadmin.tar.xz \
	&& curl -fsSL "https://files.phpmyadmin.net/phpMyAdmin/${PHPMYADMIN_VERSION}/phpMyAdmin-${PHPMYADMIN_VERSION}-english.tar.xz.asc" -o phpmyadmin.tar.xz.asc \
	&& gpg --batch --verify phpmyadmin.tar.xz.asc phpmyadmin.tar.xz \
	&& tar -xvf phpmyadmin.tar.xz --strip-components=1 \
	&& rm -v phpmyadmin.tar.xz* \
	&& chown -R www-data:www-data .

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["apache2-foreground"]
