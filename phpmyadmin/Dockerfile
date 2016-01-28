FROM php:5.6-apache

RUN apt-get update && apt-get install -y --no-install-recommends \
		libmcrypt-dev \
		xz-utils \
	&& rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install mbstring mcrypt mysqli
RUN pecl install uploadprogress && docker-php-ext-enable uploadprogress

RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 436FF1884B1A0C3FDCBF0D79FEFC65D181AF644A

ENV PHPMYADMIN_VERSION 4.5.4

RUN set -x \
	&& curl -fsSL "https://files.phpmyadmin.net/phpMyAdmin/${PHPMYADMIN_VERSION}/phpMyAdmin-${PHPMYADMIN_VERSION}-english.tar.xz" -o phpmyadmin.tar.xz \
	&& curl -fsSL "https://files.phpmyadmin.net/phpMyAdmin/${PHPMYADMIN_VERSION}/phpMyAdmin-${PHPMYADMIN_VERSION}-english.tar.xz.asc" -o phpmyadmin.tar.xz.asc \
	&& gpg --verify phpmyadmin.tar.xz.asc \
	&& tar -xvf phpmyadmin.tar.xz --strip-components=1 \
	&& rm -v phpmyadmin.tar.xz* \
	&& chown -R www-data:www-data .

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["apache2-foreground"]
