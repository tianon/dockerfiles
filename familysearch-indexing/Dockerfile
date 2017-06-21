FROM i386/debian:wheezy-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
		ca-certificates \
		wget \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/share/man/man1 \
	&& apt-get update && apt-get install -y --no-install-recommends \
		openjdk-6-jre \
	&& rm -rf /var/lib/apt/lists/*

ENV HOME /root
RUN wget -O "$HOME/setup.sh" https://indexing.familysearch.org/downloads/Indexing_unix.sh
RUN echo 'o\nn\nn\nn\nn\nn\nn\nn\nn\nn\nn\nn\nn\nn\nn\nn\nn' | sh $HOME/setup.sh
CMD ["/usr/share/fs-indexing/indexing.familysearch.org/indexing"]

# TODO add a very lightweight browser for opening help and/or registration
