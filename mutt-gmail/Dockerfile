FROM debian:stable

RUN groupadd -g 1000 user \
	&& useradd --create-home -d /home/user -g user -u 1000 user

RUN apt-get update && apt-get install -y ca-certificates mutt-patched

# a browser is necessary!
RUN apt-get update && apt-get install -y lynx
ENV BROWSER lynx

# my preferred editor :) (see also muttrc)
RUN apt-get update && apt-get install -y vim-nox

USER user
ENV HOME /home/user
RUN mkdir -p $HOME/.mutt/cache/headers $HOME/.mutt/cache/bodies \
	&& touch $HOME/.mutt/certificates

ENV LANG C.UTF-8

ADD muttrc $HOME/.muttrc
ADD vimrc $HOME/.vimrc

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["mutt-patched"]
