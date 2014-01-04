FROM debian:wheezy

RUN apt-get update && apt-get install -yq mutt vim-nox
RUN mkdir -p /.mutt/cache/headers /.mutt/cache/bodies && touch /.mutt/certificates

ADD muttrc /.muttrc
ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["mutt"]
