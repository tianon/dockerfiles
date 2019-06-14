true-asm: true.asm
	nasm -o $@ $<
	chmod +x true-asm

true-c: true.c
	gcc -o $@ -static -Os -nostartfiles -fno-asynchronous-unwind-tables $<
	strip $@

true-go: true.go
	CGO_ENABLED=0 go build -o $@ -ldflags '-d -s -w' $<

# https://doc.rust-lang.org/edition-guide/rust-2018/platform-and-target-support/musl-support-for-fully-static-binaries.html
true-rust: true.rs
	rustc --target x86_64-unknown-linux-musl -o $@ $<
	strip $@

true-tinygo: true.go
	tinygo build -o $@ -no-debug -opt s $<
	strip $@

.PHONY: all
all: true-asm true-c true-go true-rust true-tinygo
.PHONY: clean
clean:
	rm -f true-asm true-c true-go true-rust true-tinygo
