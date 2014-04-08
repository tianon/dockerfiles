FROM debian:sid

# normal build deps
RUN apt-get update && apt-get install -yq \
		build-essential \
		devscripts \
		dh-make \
		equivs \
		libcrypt-ssleay-perl \
		libfile-fcntllock-perl \
		libwww-perl \
		lintian \
		python3-debian \
		--no-install-recommends

# need an editor for "dch -i"
RUN apt-get update && apt-get install -yq vim-nox --no-install-recommends

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
} >> /root/.bash_history

CMD ["bash"]
