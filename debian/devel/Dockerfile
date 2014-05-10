FROM debian:experimental

# normal build deps
RUN apt-get update && apt-get install -yq \
		build-essential \
		devscripts \
		dh-make \
		dput-ng \
		equivs \
		git bzr mercurial subversion \
		libcrypt-ssleay-perl \
		libfile-fcntllock-perl \
		libwww-perl \
		lintian \
		python-distro-info \
		python3-debian \
		--no-install-recommends

# need an editor for "dch -i"
RUN apt-get update && apt-get install -yq vim --no-install-recommends

# a few extra little useful things
RUN apt-get update && apt-get install -yq bash-completion curl less wget

# need deb-src for compiling packages
RUN echo 'deb-src http://http.debian.net/debian sid main' >> /etc/apt/sources.list && \
	apt-get update

# tianon is _really_ lazy, and likes a preseeded bash history
ENV HOME /root
RUN { \
	echo "export DEBFULLNAME='' DEBEMAIL=''"; \
	echo 'dch -i'; \
	echo 'lintian --ftp-master-rejects'; \
	echo 'uscan --force-download --verbose --download-current-version'; \
} >> "$HOME/.bash_history"

# make sure things are pretty
ENV LANG C.UTF-8
ENV TERM xterm-256color
RUN cp /etc/skel/.bashrc /root/ \
	&& sed -ri 's/^#(force_color_prompt=yes)/\1/' /root/.bashrc

ADD prep-source-package.sh /tianon-prep-source-package.sh

CMD ["bash"]
