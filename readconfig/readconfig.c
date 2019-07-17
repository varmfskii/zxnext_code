#include <stdio.h>
#include <sys/ioctl.h>
#include "readconfig.h"

int main() {
  ioctl(1, IOCTL_OTERM_PAUSE, 0);
  startserver();
  endserver();
  return 0;
}
