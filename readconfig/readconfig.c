#include <stdio.h>
#include <sys/ioctl.h>
#include "readconfig.h"

int main() {
  ioctl(1, IOCTL_OTERM_PAUSE, 0);
  startserver();
  return 0;
}
