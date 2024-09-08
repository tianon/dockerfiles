#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:bullseye-slim

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
	; \
	rm -rf /var/lib/apt/lists/*

ENV HOME /home/user
RUN set -eux; \
	useradd --create-home --home-dir "$HOME" user; \
	mkdir "$HOME/.weechat"; \
	chown -R user:user "$HOME"

# https://weechat.org/files/doc/devel/weechat_faq.en.html#charset
ENV LANG C.UTF-8

# https://weechat.org/download/debian/
RUN set -eux; \
	savedAptMark="$(apt-mark showmanual)"; \
	apt-get update; \
	apt-get install -y --no-install-recommends gnupg; \
	\
	GNUPGHOME="$(mktemp -d)"; export GNUPGHOME; \
	gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys 11E9DE8848F2B65222AA75B8D1820DB22A11534E; \
	gpg --batch --export --armor 11E9DE8848F2B65222AA75B8D1820DB22A11534E > /usr/local/share/weechat-keyring.gpg.asc; \
	gpgconf --kill all; \
	rm -rf "$GNUPGHOME"; unset GNUPGHOME; \
	\
	apt-mark auto '.*' > /dev/null; \
	[ -z "$savedAptMark" ] || apt-mark manual $savedAptMark > /dev/null; \
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	\
	suite="$(awk '$1 == "deb" { print $3; exit }' /etc/apt/sources.list)"; \
	echo "deb [signed-by=/usr/local/share/weechat-keyring.gpg.asc] https://weechat.org/debian $suite main" > /etc/apt/sources.list.d/weechat.list; \
	\
	apt-get update; \
	rm -rf /var/lib/apt/lists/*

# https://weechat.org/download/stable/
# https://weechat.org/download/debian/active/#debian_bullseye
ENV WEECHAT_VERSION 4.4.2-1

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		weechat="$WEECHAT_VERSION" \
		weechat-curses="$WEECHAT_VERSION" \
		weechat-plugins="$WEECHAT_VERSION" \
	; \
	rm -rf /var/lib/apt/lists/*

WORKDIR $HOME
USER user
CMD ["weechat"]
