FROM ubuntu:12.04

RUN apt-get update && apt-get install -yq curl

RUN apt-get update && \
	curl -L http://media.steampowered.com/client/installer/steam.deb -o /steam.deb && \
	{ dpkg -i /steam.deb || apt-get install -yq -f ;} && \
	rm /steam.deb

# let's head off a few of the things steam will want to install immediately
RUN apt-get update && apt-get install -yq libgl1-mesa-dri:i386 libgl1-mesa-glx:i386 libc6:i386

# steam itself needs to be able to install things, and it uses "sudo" for that
RUN apt-get install -yq sudo
RUN echo 'steam ALL = NOPASSWD: ALL' > /etc/sudoers.d/steam && chmod 0440 /etc/sudoers.d/steam

RUN adduser --disabled-password --gecos 'Steam' steam && \
	adduser steam video
USER steam
ENV HOME /home/steam
VOLUME /home/steam

CMD ["steam"]
