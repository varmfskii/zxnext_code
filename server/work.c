#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "readconfig.h"

void work(void) {
  char *msg;
  uint8_t n;
  uint16_t len, i;
  
  for(;;) {
    msg=netrx(&n, &len);
    printf("%d:", len);
    for(i=0; i<len; i++) putchar(msg[i]);
    putchar('\n');
    if (!strncmp(msg, "exit", 4)) break;
    free(msg);
    if (nettx("rxed\r\n", n, 6)) break;
  }
  nettx("exit\r\n", n, 6);
  puts("closing connection");
  netclose(n);
}
