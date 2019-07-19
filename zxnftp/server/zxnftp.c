#include <stdio.h>
#include <sys/ioctl.h>
#include "zxnftp.h"

int main() {
  puts("ZX Spectrum Next simple server");
  ioctl(1, IOCTL_OTERM_PAUSE, 0);
  puts("starting server");
  if (startserver()) return 1;
  puts("server started");
  work();
  puts("stopping server");
  endserver();
  puts("done");
  return 0;
}
