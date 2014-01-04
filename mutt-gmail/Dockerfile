FROM debian:wheezy

RUN apt-get update && apt-get install -yq ca-certificates mutt
RUN mkdir -p /.mutt/cache/headers /.mutt/cache/bodies && touch /.mutt/certificates

# a browser is necessary!
RUN apt-get update && apt-get install -yq lynx
ENV BROWSER lynx

# my preferred editor :) (see also muttrc)
RUN apt-get update && apt-get install -yq vim-nox

ADD muttrc /.muttrc
ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["mutt"]
