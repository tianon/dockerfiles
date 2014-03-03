FROM debian:stable

RUN apt-get update && apt-get install -yq ca-certificates mutt-patched

ENV HOME /root

RUN mkdir -p $HOME/.mutt/cache/headers $HOME/.mutt/cache/bodies && touch $HOME/.mutt/certificates

# a browser is necessary!
RUN apt-get update && apt-get install -yq lynx
ENV BROWSER lynx

# my preferred editor :) (see also muttrc)
RUN apt-get update && apt-get install -yq vim-nox

ENV LANG C.UTF-8

ADD muttrc $HOME/.muttrc
ADD vimrc $HOME/.vimrc

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["mutt-patched"]
