#include <unistd.h>
#include <sys/syscall.h>
void _start() { /* _exit(0); */ syscall(SYS_exit, 0); }
