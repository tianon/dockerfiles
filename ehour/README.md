When I run it, I run with a custom properties file (because otherwise, the image is hard-coded to use `mysql` as the DB host name, `user` as the user, and `pass` as the password, as can be seen in the default `/usr/local/ehour/home/conf/ehour.properties` file in the image) and a dedicated network for eHour and MySQL, something like this:

```console
$ docker network create ehour
$ docker run -dit --name ehour-mysql --restart always --memory 512m --network ehour --network-alias mysql --stop-timeout 60 -v ehour-mysql:/var/lib/mysql -e MYSQL_RANDOM_ROOT_PASSWORD=1 -e MYSQL_USER=ehour -e MYSQL_PASSWORD=some-super-secure-random-string -e MYSQL_DATABASE=ehour mysql:5.7
$ cat ehour.properties
ehour.standalone.port=8000
ehour.database=mysql
ehour.database.url=mysql://ehour:some-super-secure-random-string@mysql:3306/ehour?zeroDateTimeBehavior=convertToNull&amp;useOldAliasMetadataBehavior=true
ehour.database.checkouttimeout=2000
ehour.configurationType=DEPLOYMENT
ehour.translations=%ehour.home%/resources/i18n
ehour.database.cp=hikari
$ docker run -dit --name ehour --restart always --network ehour -v "$PWD/ehour.properties":/usr/local/ehour/home/conf/ehour.properties:ro tianon/ehour

$ # if it's your first install, you'll need to initialize the database
$ docker cp ehour:/usr/local/ehour/sql/mysql/install/fresh.mysql.sql ./
$ docker exec -i ehour-mysql sh -c 'mysql -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE' < fresh.mysql.sql
$ docker restart ehour
$ # (default username/password once it comes back up should be admin/admin)

$ # if it's an upgrade, you'll need to perform any necessary database migrations
$ # see /usr/local/ehour/sql/mysql/upgrade in the ehour container for the necessary .sql files
$ # (whose names should be reasonably self-explanatory)
```
