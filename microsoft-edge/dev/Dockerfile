#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:trixie-slim

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
		fonts-dejavu \
		fonts-noto-color-emoji \
		libgl1 \
		libgl1-mesa-dri \
		libpulse0 \
# TODO mesa-vulkan-drivers ? ("Warning: vkCreateInstance: Found no drivers!") -- adding didn't seem to change anything except remove the warning (still "Disabled" in "about:gpu") 🤷
	; \
	apt-get dist-clean

# https://www.microsoftedgeinsider.com/en-us/download/?platform=linux-deb

RUN set -eux; \
	savedAptMark="$(apt-mark showmanual)"; \
	apt-get update; \
	apt-get install -y --no-install-recommends gnupg; \
	apt-get dist-clean; \
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --batch --keyserver keyserver.ubuntu.com --recv-keys BC528686B50D79E339D3721CEB3E94ADBE1229CF; \
	mkdir -p /etc/apt/untrusted.gpg.d; \
	gpg --batch --export --armor BC528686B50D79E339D3721CEB3E94ADBE1229CF > /etc/apt/untrusted.gpg.d/microsoft.gpg.asc; \
	gpgconf --kill all; \
	rm -rf "$GNUPGHOME"; \
	apt-mark auto '.*' > /dev/null; \
	apt-mark manual $savedAptMark > /dev/null; \
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	\
# TODO non-amd64? 👀
# https://packages.microsoft.com/repos/edge/dists/stable/main/
	echo 'deb [ arch=amd64 signed-by=/etc/apt/untrusted.gpg.d/microsoft.gpg.asc ] https://packages.microsoft.com/repos/edge stable main' > /etc/apt/sources.list.d/microsoft-edge.list; \
	apt-get update; \
	apt-get dist-clean; \
	\
# disable/exclude some key auto-update behavior
	echo 'path-exclude /etc/cron*/microsoft-edge*' | tee /etc/dpkg/dpkg.cfg.d/microsoft-edge; \
	{ \
		echo 'repo_add_once="false"'; \
		echo 'repo_reenable_on_distupgrade="false"'; \
	} | tee /etc/default/microsoft-edge-dev

# https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-dev/
ENV EDGE_VERSION 146.0.3856.13-1

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		"microsoft-edge-dev=$EDGE_VERSION" \
	; \
	apt-get dist-clean; \
	microsoft-edge-dev --version; \
	microsoft-edge --version

CMD ["microsoft-edge"]
