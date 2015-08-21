FROM docker:dind

RUN apk add --update \
		git \
		openjdk7-jre \
		openssh \
	&& rm -rf /var/cache/apk/*

RUN ssh-keygen -A
RUN echo 'root:docker' | chpasswd

EXPOSE 22
COPY i-am-a-terrible-person.sh /
ENTRYPOINT ["/i-am-a-terrible-person.sh"]
CMD []
