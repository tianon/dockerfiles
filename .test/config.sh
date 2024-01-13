#!/usr/bin/env bash

# https://github.com/docker-library/official-images/blob/3e27b6eb7a12bc15e5e2dde52d2477c818863ce3/test/config.sh

imageTests+=(
	[tianon/true]='true'

	# run containerd test on containerd-containing images :D
	[tianon/containerd:c8dind]='c8dind'
	[tianon/docker-master]='c8dind'
	[tianon/infosiftr-moby]='c8dind'
	[infosiftr/moby]='c8dind'

	# make sure our buildkit image works correctly with buildx
	[tianon/buildkit]='buildkitd'

	# avoid: java.lang.UnsatisfiedLinkError: /opt/java/openjdk/lib/libfontmanager.so: libfreetype.so.6: cannot open shared object file: No such file or directory
	[tianon/jenkins]='java-uimanager-font'
)

globalExcludeTests+=(
	# single-binary images
	[tianon/sleeping-beauty_no-hard-coded-passwords]=1
	[tianon/sleeping-beauty_utc]=1
	[tianon/true_no-hard-coded-passwords]=1
	[tianon/true_utc]=1

	# needs --privileged (by design)
	[tianon/containerd:c8dind_override-cmd]=1
)

# run Docker tests on Docker images :D
testAlias+=(
	[tianon/docker-master]='docker:dind'
	[tianon/infosiftr-moby]='docker:dind'
	[infosiftr/moby]='docker:dind'
)
# the "docker-registry-push-pull" test isn't very good at detecting whether our custom image is dind or registry O:)
globalExcludeTests+=(
	[tianon/docker-master_docker-registry-push-pull]=1
	[tianon/infosiftr-moby_docker-registry-push-pull]=1
	[infosiftr/moby_docker-registry-push-pull]=1
)

# Cygwin looks like Unix, but fails in cute ways (host timezone instead of "UTC" because Windows, can't scrape "/etc/passwd" because --user)
globalExcludeTests+=(
	[tianon/cygwin_no-hard-coded-passwords]=1
	[tianon/cygwin_utc]=1
)
