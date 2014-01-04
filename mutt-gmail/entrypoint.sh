#!/bin/bash
set -e

if [ ! "$GMAIL" ]; then
	echo >&2 'error: missing GMAIL environment variable'
	echo >&2 '  try running again with -e GMAIL=your-email@gmail.com'
	echo >&2 '    optionally, you can also specify -e GMAIL_FROM=email@your-domain.com'
	echo >&2 '    and also -e GMAIL_NAME="Your Name"'
	echo >&2 '      if not specified, both default to the value of GMAIL'
	exit 1
fi

if [ ! "$GMAIL_FROM" ]; then
	GMAIL_FROM="$GMAIL"
fi
if [ ! "$GMAIL_NAME" ]; then
	GMAIL_NAME="$GMAIL_FROM"
fi

sed -i "s/%GMAIL_LOGIN%/$GMAIL/g" /.muttrc
sed -i "s/%GMAIL_FROM%/$GMAIL_FROM/g" /.muttrc
sed -i "s/%GMAIL_NAME%/$GMAIL_NAME/g" /.muttrc

exec "$@"
