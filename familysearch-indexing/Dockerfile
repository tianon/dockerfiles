FROM debian:wheezy

RUN apt-get update && apt-get install -yq curl

RUN dpkg --add-architecture i386 && \
	apt-get update && \
	apt-get install -yq openjdk-6-jre:i386

ENV HOME /root
RUN curl -L https://indexing.familysearch.org/downloads/Indexing_unix.sh -o $HOME/setup.sh
RUN echo 'o\nn\nn\nn\nn\nn\nn\nn\nn\nn\nn\nn\nn\nn\nn\nn\nn' | sh $HOME/setup.sh
CMD /usr/share/fs-indexing/indexing.familysearch.org/indexing

# TODO add a very lightweight browser for opening help and/or registration
