FROM debian:experimental

# normal build deps
RUN apt-get update && apt-get install -y \
		bash-completion curl less rsync vim wget \
		build-essential \
		devscripts \
		dh-make \
		dput-ng \
		equivs \
		git bzr mercurial subversion \
		git-buildpackage svn-buildpackage \
		libcrypt-ssleay-perl \
		libdistro-info-perl \
		libfile-fcntllock-perl \
		libwww-perl \
		lintian \
		openssh-client \
		python-distro-info \
		python3-debian \
		quilt \
		--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

# need deb-src for compiling packages
RUN find /etc/apt/sources.list* -type f -exec sed -i 'p; s/^deb /deb-src /' '{}' +

# let's make apt list package versions, since those are handy during devel
RUN echo 'APT::Get::Show-Versions "1";' > /etc/apt/apt.conf.d/verbose

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
RUN cp /etc/skel/.bashrc ~/ \
	&& sed -ri 's/^#(force_color_prompt=yes)/\1/' ~/.bashrc

# quilt is much amaze: https://wiki.debian.org/UsingQuilt#Using_quilt_with_Debian_source_packages
ENV QUILT_PATCHES debian/patches
ENV QUILT_REFRESH_ARGS -p ab --no-timestamps --no-index

COPY scripts /tianon
