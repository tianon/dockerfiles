true-asm: true.asm
	nasm -o $@ $<
	chmod +x true-asm

true-c: true.c
	gcc -Os -o $@ -static $<

true-go: true.go
	CGO_ENABLED=0 go build -o $@ -ldflags '-d -s -w' $<

.PHONY: all
all: true-asm true-c true-go
.PHONY: clean
clean:
	rm -f true-asm true-c true-go
