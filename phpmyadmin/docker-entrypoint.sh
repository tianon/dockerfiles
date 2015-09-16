#!/bin/bash
set -e

php_escape() {
	php -r 'var_export((string) $argv[1]);' "$1"
}

if [ "$MYSQL_PORT_3306_TCP" -a ! -f config.inc.php ]; then
	cat > config.inc.php <<EOF
<?php
\$cfg['Servers'] = array(
	1 => array(
		'host' => 'mysql',
		'auth_type' => 'config',
		'user' => 'root',
		'password' => $(php_escape "$MYSQL_ENV_MYSQL_ROOT_PASSWORD"),
	),
);
EOF
fi

exec "$@"
