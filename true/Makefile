SHELL := $(shell if command -v bash > /dev/null; then echo /usr/bin/env bash -Eeuo pipefail; else echo /usr/bin/env sh -eu; fi)

true-asm: true.asm
	nasm -o $@ $<
	chmod +x $@
	nasm --version > $@.meta

true-yolo: true-yolo.asm
	nasm -o $@ $<
	chmod +x $@
	nasm --version > $@.meta

true-gcc: true.c
	gcc -Wl,--strip-all -o $@ -static -Os -nostartfiles -fno-asynchronous-unwind-tables $<
	gcc --version > $@.meta

true-go: true.go
	CGO_ENABLED=0 go build -o $@ -ldflags '-d -s -w' $<
	go version > $@.meta

# https://doc.rust-lang.org/edition-guide/rust-2018/platform-and-target-support/musl-support-for-fully-static-binaries.html
true-rust: true.rs
	rustc --target x86_64-unknown-linux-musl -o $@ $<
	strip $@ # hmm
	rustc --version > $@.meta

true-tinygo: true.go
	tinygo build -o $@ -no-debug -opt s $<
	strip $@ # hmm
	tinygo version > $@.meta

.PHONY: all
all: true-asm true-yolo true-gcc true-go true-rust true-tinygo
.PHONY: clean
clean:
	set -x; rm -f true-{asm,yolo,gcc,go,rust,tinygo}{,.meta}
