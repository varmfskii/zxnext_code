#include <stdio.h>
#include <sys/ioctl.h>
#include "server.h"

int main() {
  //ioctl(1, IOCTL_OTERM_PAUSE, 0);
  puts("starting server");
  if (startserver()) return 1;
  puts("server started");
  work();
  puts("stopping server");
  endserver();
  puts("done");
  return 0;
}
