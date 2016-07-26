FROM docker:dind

RUN apk add --update \
		bash \
		git \
		openjdk7-jre \
		openssh \
	&& rm -rf /var/cache/apk/*

RUN ssh-keygen -A
RUN echo 'root:docker' | chpasswd
RUN sed -ri 's/^#?PermitRootLogin[[:space:]].*$/PermitRootLogin yes/g' /etc/ssh/sshd_config

# let's make /root a volume so ~/.ssh/authorized_keys is easier to save
VOLUME /root

EXPOSE 22
COPY i-am-a-terrible-person.sh /
ENTRYPOINT ["/i-am-a-terrible-person.sh"]
CMD []
