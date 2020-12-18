FROM debian:buster-slim

RUN groupadd -g 1000 user \
	&& useradd --create-home -d /home/user -g user -u 1000 user

RUN echo 'path-include /usr/share/doc/mutt/examples/*' >> /etc/dpkg/dpkg.cfg.d/mutt

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
		mutt \
# a browser is necessary!
		lynx \
# my preferred editor :) (see also muttrc)
		vim-nox \
# "No authenticators available"
		libsasl2-modules \
# "GPGME: CMS protocol not available"
		gpgsm \
	; \
	rm -rf /var/lib/apt/lists/*

ENV BROWSER lynx

USER user
ENV HOME /home/user
RUN mkdir -p $HOME/.mutt/cache/headers $HOME/.mutt/cache/bodies \
	&& touch $HOME/.mutt/certificates

ENV LANG C.UTF-8

COPY muttrc $HOME/.muttrc
COPY vimrc $HOME/.vimrc

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["mutt"]
