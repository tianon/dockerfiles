FROM debian:experimental

# normal build deps
RUN apt-get update && apt-get install -y \
		build-essential \
		devscripts \
		dh-make \
		dput-ng \
		equivs \
		git bzr mercurial subversion \
		git-buildpackage svn-buildpackage \
		libcrypt-ssleay-perl \
		libfile-fcntllock-perl \
		libwww-perl \
		lintian \
		openssh-client \
		python-distro-info \
		python3-debian \
		quilt \
		--no-install-recommends

# need an editor for "dch -i"
RUN apt-get update && apt-get install -yq vim --no-install-recommends

# a few extra little useful things
RUN apt-get update && apt-get install -yq bash-completion curl less wget

# need deb-src for compiling packages
RUN sed -i 'p; s/^deb /deb-src /' /etc/apt/sources.list /etc/apt/sources.list.d/experimental.list && \
	apt-get update

# tianon is _really_ lazy, and likes a preseeded bash history
ENV HOME /root
RUN { \
	echo "export DEBFULLNAME='' DEBEMAIL=''"; \
	echo 'dch -i'; \
	echo 'lintian --ftp-master-rejects'; \
	echo 'uscan --force-download --verbose --download-current-version'; \
} >> ~/.bash_history

# for ssh to debian hosts, let's make sure we know their fingerprints <3
RUN mkdir -p ~/.ssh && chmod 700 ~/.ssh \
	&& wget -O ~/.ssh/known_hosts https://db.debian.org/debian_known_hosts \
	&& chmod 644 ~/.ssh/known_hosts

# make sure things are pretty
ENV LANG C.UTF-8
ENV TERM xterm-256color
RUN cp /etc/skel/.bashrc /root/ \
	&& sed -ri 's/^#(force_color_prompt=yes)/\1/' /root/.bashrc

# quilt is much amaze: https://wiki.debian.org/UsingQuilt#Using_quilt_with_Debian_source_packages
ENV QUILT_PATCHES debian/patches
ENV QUILT_REFRESH_ARGS -p ab --no-timestamps --no-index

ADD scripts /tianon

CMD ["bash"]
