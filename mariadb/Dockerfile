FROM debian:wheezy

RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db && echo 'deb http://ftp.osuosl.org/pub/mariadb/repo/5.5/debian wheezy main' > /etc/apt/sources.list.d/mariadb.list

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yq mariadb-server

RUN sed -ri 's/^(bind-address|skip-networking)/;\1/' /etc/mysql/my.cnf

RUN service mysql start && \
	mysql -v -uroot -e'UPDATE user SET host = "%" WHERE user = "root" LIMIT 1; DELETE FROM user WHERE user = "root" AND host != "%"' mysql && \
	service mysql stop

VOLUME /var/lib/mysql
EXPOSE 3306

CMD [ "mysqld_safe", "--skip-syslog" ]
