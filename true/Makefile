true-asm: true.asm
	nasm -o $@ $<
	chmod +x true-asm

true-c: true.c
	gcc -Os -o $@ -static $<

true-go: true.go
	go build -o $@ -ldflags -d $<

all: true-asm true-c true-go
clean:
	rm -f true-asm true-c true-go
