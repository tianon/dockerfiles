FROM debian:buster-slim

RUN apt-get update && apt-get install -y \
		biber \
		latexmk \
		make \
		texlive-full \
		python-pygments\
	&& rm -rf /var/lib/apt/lists/*
