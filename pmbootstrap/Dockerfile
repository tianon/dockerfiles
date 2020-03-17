FROM python:3-alpine3.11

RUN apk add --no-cache coreutils git openssl sudo

RUN set -eux; \
	echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/wheel; \
# https://gitlab.alpinelinux.org/alpine/aports/issues/11122
	echo 'Set disable_coredump false' >> /etc/sudo.conf; \
# verify there are no errors/warnings
	out="$(sudo true 2>&1)"; \
	[ -z "$out" ]

# https://pypi.org/project/pmbootstrap/
ENV PMBOOTSTRAP_VERSION 1.17.0

RUN pip install "pmbootstrap == $PMBOOTSTRAP_VERSION"

# workaround issues with transparent QEMU / binfmt detection ("fix binary" -- qemu binaries not necessary inside chroots/namespaces)
RUN sed -ri -e '/^def setup_qemu_emulation/a \ \ \ \ return' /usr/local/lib/python*/site-packages/pmb/chroot/init.py

CMD ["sh"]
