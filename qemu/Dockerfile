FROM debian:sid

RUN apt-get update && apt-get install -y \
		qemu-kvm \
		qemu-system \
		qemu-utils \
		--no-install-recommends

EXPOSE 22
EXPOSE 5900

COPY start-qemu /usr/local/bin/
CMD ["start-qemu"]
