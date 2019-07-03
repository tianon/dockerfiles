# https://bugs.launchpad.net/bugs/1440372 (python3)
FROM python:3.7-alpine

RUN apk add --no-cache gnupg

# https://pypi.org/project/b2/
ENV B2_VERSION 1.4.0
# duplicity doesn't publish a "supported b2 modules versions" list, so I've tried to match the b2 module version to the latest that was available at the time of the current duplicity release
# duplicity 0.8.00 is ~29-May-2019, b2 1.4.0 is ~26-Apr-2019

RUN set -eux; \
	pip install --no-cache-dir "b2 == $B2_VERSION"

# http://duplicity.nongnu.org/
# https://download.savannah.gnu.org/releases/duplicity/?C=S&O=D
ENV DUPLICITY_VERSION 0.8.00
# https://bazaar.launchpad.net/~duplicity-team/duplicity/0.8-series/view/head:/CHANGELOG

RUN set -eux; \
	apk add --no-cache --virtual .build-deps gcc libc-dev librsync-dev; \
	pip install --no-cache-dir "https://download.savannah.gnu.org/releases/duplicity/duplicity-$DUPLICITY_VERSION.tar.gz"; \
	apk add --no-network --virtual .duplicity-deps librsync; \
	apk del --no-network .build-deps; \
	duplicity --version
