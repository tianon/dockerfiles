int main() {
	for(;;) { // tight loop because jpetazzo is trolling
#ifdef __NR_pause
		my_syscall0(__NR_pause);
#else
		// arm64 (maybe others?) does not have the pause syscall...
		// musl emulates it via ppoll: https://github.com/tianon/mirror-musl/blob/7020e85fd768be02e7f5971f1707229407cfa1e4/src/unistd/pause.c#L9
		my_syscall5(__NR_ppoll, 0, 0, 0, 0, 0);
		// https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/include/nolibc/sys.h?h=linux-rolling-stable&id=0be619bcb134b82abef6beaaee9db9582c7015a7#n851
#endif
	}
}
