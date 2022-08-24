#!/usr/bin/env bash
set -Eeuo pipefail

dockerfiles=( $(ls -1 Dockerfile.* | tac) )

images=()
for df in "${dockerfiles[@]}"; do
	version="${df#Dockerfile.}"
	if [ "$version" = 'template' ]; then
		continue
	fi
	image="tianon/cygwin:win$version"
	( set -x; docker build --tag "tianon/cygwin:win$version" --pull --file "$df" . )
	images+=( "$image" )
done

cat > latest.yml <<-'EOH'
	image: tianon/cygwin:latest
	manifests:
EOH
for image in "${images[@]}"; do
	( set -x; docker push "$image" )
	echo "  - image: $image" >> latest.yml
done

( set -x; manifest-tool push from-spec latest.yml )
