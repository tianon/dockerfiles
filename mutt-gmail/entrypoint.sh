#!/bin/bash
set -e

if [ "$1" = 'mutt' ]; then
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

	sed -i \
		-e "s/%GMAIL_LOGIN%/$GMAIL/g" \
		-e "s/%GMAIL_FROM%/$GMAIL_FROM/g" \
		-e "s/%GMAIL_NAME%/$GMAIL_NAME/g" \
		-e "s/%GMAIL_PASS%/$GMAIL_PASS/g" \
		"$HOME/.muttrc"

	if [ -d "$HOME/.gnupg" ]; then
		{
			echo
			#echo 'source /usr/share/doc/mutt/examples/gpg.rc'
			echo 'set pgp_use_gpg_agent = yes'
			if [ "$GPG_ID" ]; then
				echo "set pgp_sign_as = $GPG_ID"
			fi
			echo 'set crypt_replysign = yes'
			echo 'set crypt_replysignencrypted = yes'
			echo 'set crypt_verify_sig = yes'
		} >> "$HOME/.muttrc"
	fi

	if [ -e "$HOME/.muttrc.local" ]; then
		echo "source $HOME/.muttrc.local" >> "$HOME/.muttrc"
	fi
fi

exec "$@"
