#include <stdio.h>
#include <sys/ioctl.h>

int main() {
  int i;

  ioctl(1, IOCTL_OTERM_PAUSE, 0);
  for(i=0; i<256; i++) printf("%d\n", i);
  return 0;
}
