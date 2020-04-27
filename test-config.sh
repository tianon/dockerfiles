#!/usr/bin/env bash

# https://github.com/docker-library/official-images/blob/3e27b6eb7a12bc15e5e2dde52d2477c818863ce3/test/config.sh

# single-binary images
globalExcludeTests+=(
	[tianon/sleeping-beauty_no-hard-coded-passwords]=1
	[tianon/sleeping-beauty_utc]=1
	[tianon/true_no-hard-coded-passwords]=1
	[tianon/true_utc]=1
)

# ONBUILD
explicitTests+=(
	[tianon/github-pages]=1
)

# run Docker tests on Docker images :D
testAlias+=(
	[tianon/docker-master]='docker'
	[tianon/docker-tianon]='docker:dind'
)
# the "docker-registry-push-pull" test isn't very good at detecting whether our custom image is dind or registry O:)
globalExcludeTests+=(
	[tianon/docker-master_docker-registry-push-pull]=1
	[tianon/docker-tianon_docker-registry-push-pull]=1
)
