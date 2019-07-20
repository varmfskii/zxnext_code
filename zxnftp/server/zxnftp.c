#include <stdio.h>
#include <sys/ioctl.h>
#include "zxnftp.h"

char buf[BLKSZ];
const char *cstrs[] = {
		  "OK\n"
};

int main() {
  puts("ZX Spectrum Next ZXNFTP server");
  ioctl(1, IOCTL_OTERM_PAUSE, 0);
  puts("starting server");
  if (startserver()) return 1;
  puts("server started");
  work();
  return 0;
}
