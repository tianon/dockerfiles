FROM debian:wheezy

RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db && echo 'deb http://ftp.osuosl.org/pub/mariadb/repo/5.5/debian wheezy main' > /etc/apt/sources.list.d/mariadb.list

RUN apt-get update && apt-get install -y mariadb-server

RUN sed -ri 's/^(bind-address|skip-networking)/;\1/' /etc/mysql/my.cnf

ADD https://raw.githubusercontent.com/docker-library/mysql/fd3bd505c6c7ae5b17cae7abe63311c8b8bb6d12/docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

RUN rm -rf /var/lib/mysql && mkdir /var/lib/mysql
VOLUME /var/lib/mysql

EXPOSE 3306
CMD ["mysqld", "--datadir=/var/lib/mysql", "--user=mysql"]
