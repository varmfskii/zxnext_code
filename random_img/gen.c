#include <stdio.h>
#include <stdlib.h>

int main() {
  int i, j;
  printf("\torg $4000\n");
  for(i=0; i<6144; i+=16) {
    printf("\tdefb $%02x", rand()&0xff);
    for(j=1; j<16; j++) {
      printf(",$%02x", rand()&0xff);
    }
    putchar('\n');
  }
  printf("\torg $5900\n");
  for(i=0; i<256; i+=16) {
    printf("\tdefb $%02x", rand()&0xff);
    for(j=1; j<16; j++) {
      printf(",$%02x", rand()&0xff);
    }
    putchar('\n');
  }
  return 0;
}
