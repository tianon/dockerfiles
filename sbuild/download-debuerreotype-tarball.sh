#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

suite="$1"; shift
hostArch="$(dpkg --print-architecture)"
arch="${1:-$hostArch}"

case "$arch" in
	amd64 | i386 | s390x) bashbrewArch="$arch" ;;
	arm64) bashbrewArch='arm64v8' ;;
	armel) bashbrewArch='arm32v5' ;;
	armhf) bashbrewArch='arm32v7' ;;
	mips64el) bashbrewArch='mips64le' ;;
	ppc64el) bashbrewArch='ppc64le' ;;
	*) echo >&2 "error: unknown bashbrew arch for dpkg arch '$arch'"; exit 1 ;;
esac

wget -O "$suite-$arch.tar.xz.sha256" "https://doi-janky.infosiftr.net/job/tianon/job/debuerreotype/job/$bashbrewArch/lastSuccessfulBuild/artifact/$suite/sbuild/rootfs.tar.xz.sha256"
wget -O "$suite-$arch.tar.xz" "https://doi-janky.infosiftr.net/job/tianon/job/debuerreotype/job/$bashbrewArch/lastSuccessfulBuild/artifact/$suite/sbuild/rootfs.tar.xz"
sha256="$(sha256sum "$suite-$arch.tar.xz" | cut -d' ' -f1)"
( set -x && [ "$sha256" = "$(< "$suite-$arch.tar.xz.sha256")" ] )

tee "/etc/schroot/chroot.d/$suite-$arch-sbuild" <<-EOF
	[$suite-$arch-sbuild]
	description=Debian $suite/$arch autobuilder
	groups=root,sbuild
	root-groups=root,sbuild
	profile=sbuild
	type=file
	file=$PWD/$suite-$arch.tar.xz
	source-root-groups=root,sbuild
EOF
