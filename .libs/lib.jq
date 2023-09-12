def unique_unsorted:
	# https://unix.stackexchange.com/a/738744/153467
	reduce .[] as $a ([]; if IN(.[]; $a) then . else . += [$a] end)
;
def intersection:
	# add all arrays together and bit-by-bit remove anything unique from each array
	reduce .[] as $arr (add | unique_unsorted; . - (. - $arr))
;
def deb_arch:
	{
		# https://salsa.debian.org/dpkg-team/dpkg/-/blob/main/data/cputable
		# https://wiki.debian.org/ArchitectureSpecificsMemo#Architecture_baselines
		# http://deb.debian.org/debian/dists/unstable/main/
		# http://deb.debian.org/debian/dists/stable/main/
		# https://deb.debian.org/debian-ports/dists/unstable/main/
		amd64: "amd64",
		arm32v5: "armel",
		arm32v7: "armhf",
		arm64v8: "arm64",
		i386: "i386",
		mips64le: "mips64el",
		ppc64le: "ppc64el",
		riscv64: "riscv64",
		s390x: "s390x",
	}[.]
;
def apk_arch:
	{
		# https://dl-cdn.alpinelinux.org/alpine/edge/main/
		# https://dl-cdn.alpinelinux.org/alpine/latest-stable/main/
		amd64: "x86_64",
		arm32v6: "armhf",
		arm32v7: "armv7",
		arm64v8: "aarch64",
		i386: "x86",
		ppc64le: "ppc64le",
		riscv64: "riscv64",
		s390x: "s390x",
	}[.]
;
