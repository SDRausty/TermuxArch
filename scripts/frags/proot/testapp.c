#include <stdio.h>
#include <errno.h>
#include <fcntl.h>
int main() {
int a = open("nonexistent-test-file-a", O_RDONLY);
int ae = errno;
int b = open("nonexistent-test-dir/nonexistent-test-file-b", O_RDONLY);
int be = errno;
int c = open("nonexistent-test-file-c", O_RDONLY);
int ce = errno;
printf("[%d %d %d %d %d %d]\n", a, ae, b, be, c, ce);
}
