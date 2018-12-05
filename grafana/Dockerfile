FROM debian:stretch-slim

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
		libfontconfig \
		wget \
	; \
	rm -rf /var/lib/apt/lists/*

ENV GF_PATHS_CONFIG="/etc/grafana/grafana.ini" \
	GF_PATHS_DATA="/var/lib/grafana" \
	GF_PATHS_HOME="/usr/share/grafana" \
	GF_PATHS_LOGS="/var/log/grafana" \
	GF_PATHS_PLUGINS="/var/lib/grafana/plugins" \
	GF_PATHS_PROVISIONING="/etc/grafana/provisioning"
ENV PATH $GF_PATHS_HOME/bin:$PATH

# https://github.com/grafana/grafana/releases
ENV GRAFANA_VERSION 5.4.0
# https://github.com/grafana/grafana/blob/master/packaging/docker/Dockerfile

RUN set -eux; \
	\
# https://grafana.com/grafana/download/5.3.4?platform=linux
# https://grafana.com/grafana/download/5.3.4?platform=arm
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		armhf) arch='armv7' ;; \
		arm64 | amd64) arch="$dpkgArch" ;; \
		*) echo >&2 "Unknown architecture: $dpkgArch"; exit 1 ;; \
	esac; \
# TODO verify sha256 values! (add ".sha256" to the end of this URL)
	wget -O grafana.tgz --progress=dot:giga "https://dl.grafana.com/oss/release/grafana-${GRAFANA_VERSION}.linux-${arch}.tar.gz"; \
	mkdir -p "$GF_PATHS_HOME"; \
	tar -xf grafana.tgz -C "$GF_PATHS_HOME" --strip-components=1; \
	rm grafana.tgz; \
	\
	groupadd -r -g 472 grafana; \
	useradd -r -u 472 -g grafana grafana; \
	mkdir -p \
		"$GF_PATHS_HOME/.aws" \
		"$GF_PATHS_PROVISIONING/datasources" \
		"$GF_PATHS_PROVISIONING/dashboards" \
		"$GF_PATHS_LOGS" \
		"$GF_PATHS_PLUGINS" \
		"$GF_PATHS_DATA" \
	; \
	cp "$GF_PATHS_HOME/conf/sample.ini" "$GF_PATHS_CONFIG"; \
	cp "$GF_PATHS_HOME/conf/ldap.toml" /etc/grafana/ldap.toml; \
	chown -R grafana:grafana "$GF_PATHS_DATA" "$GF_PATHS_HOME/.aws" "$GF_PATHS_LOGS" "$GF_PATHS_PLUGINS"; \
	chmod 777 "$GF_PATHS_DATA" "$GF_PATHS_HOME/.aws" "$GF_PATHS_LOGS" "$GF_PATHS_PLUGINS"; \
	grafana-server -v; \
	\
	wget -O /usr/local/bin/grafana-cmd "https://github.com/grafana/grafana/raw/v${GRAFANA_VERSION}/packaging/docker/run.sh"; \
	chmod +x /usr/local/bin/grafana-cmd

WORKDIR $GF_PATHS_HOME
VOLUME $GF_PATHS_DATA

USER grafana
EXPOSE 3000
CMD ["grafana-cmd"]
