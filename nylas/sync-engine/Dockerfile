FROM buildpack-deps:jessie-curl

RUN apt-get update && apt-get install -y --no-install-recommends \
		file \
		g++ \
		gcc \
		git \
		libffi-dev \
		liblua5.2-dev \
		libmysqlclient-dev \
		libpython-dev \
		libsodium-dev \
		libssl-dev \
		libxslt1-dev \
		pkg-config \
		python \
	&& rm -rf /var/lib/apt/lists/*
# install pip from upstream (since "python-pip" is too old)
RUN wget -O get-pip.py 'https://bootstrap.pypa.io/get-pip.py' \
	&& python get-pip.py --no-cache-dir \
	&& pip --version \
	&& rm -f get-pip.py
# tell pynacl to use system libsodium
ENV SODIUM_INSTALL system

WORKDIR /usr/src/sync-engine

#ENV SYNC_VERSION v0.3.0 # 2014 :'(
ENV SYNC_VERSION d715f4c7c2869b1e51f92af47908a9e011ae8aea

RUN curl -fSL "https://github.com/nylas/sync-engine/archive/$SYNC_VERSION.tar.gz" -o sync.tar.gz \
	&& tar -xzf sync.tar.gz --strip-components=1 \
	&& rm sync.tar.gz

# ugh, NameError: name 'PROTOCOL_SSLv3' is not defined
RUN sed -i 's/^gevent==1.0.1/gevent==1.1rc3/' requirements.txt

RUN pip install -r requirements.txt

RUN pip install .

COPY config.json secrets.yml /etc/inboxapp/

USER 1000:1000
COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]
CMD ["bash"] # TODO inbox-api or inbox-start
