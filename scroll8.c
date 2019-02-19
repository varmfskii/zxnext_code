#include <stdio.h>
#include <string.h>

void scroll1u(void);
void scroll8u(void);

char zero[32];

int main() {
  int i;
  unsigned char j;

  i=0;
  for(;;) {
    for(; i%24!=23; i++) printf("\n%02d", i);
    printf("\n%02d", i++);
    for(j=0; j<192; j++) scroll1u();
  }

  return 0;
}

void scroll8u(void) {
  char *i;
  static char zero[32];
  unsigned short j;

  for(i=(char *)0x4000; i<(char *)0x5800; i+=0x800) {
    for(j=0; j<0x800; j+=0x100)
      memcpy(i+j, i+j+0x20, 0xE0);
    if (i<(char *)0x5000) {
      for(j=0xe0; j<0x800; j+=0x100)
	memcpy(i+j, i+j+0x720, 0x20);
    } else {
      for(j=0xe0; j<0x800; j+=0x100)
	memcpy(i+j, zero, 0x20);
    }
  }
}

void scroll1u(void) {
  static char temp[256];
  char *i;

  for(i=(char *)0x4000; i<(char *)0x5000; i+=0x800) {
    memcpy(temp, i+0x20, 0xe0);
    memcpy(i, i+0x100, 0x700);
    memcpy(i+0x700, temp, 0xe0);
    memcpy(i+0x7e0, i+0x800, 0x20);
  }
  memcpy(temp, (char *)0x5020, 0x100);
  memcpy((char *)0x5000, (char *)0x5100, 0x700);
  memcpy((char *)0x5700, temp, 0xe0);
  memcpy((char *)0x57e0, zero, 0x20);
}
