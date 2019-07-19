#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "zxnftp.h"

void cmd_put(uint8_t n) {
  uint16_t sz;
  uint8_t len;
  
  n=netrxs(buf);
  printf("put %s", buf);
  // open file
  ok(n);
  for(sz=0; ; sz+=len) {
    n=netrxs(buf);
    ok(n);
    if (strcmp("RR\n", buf)) break;
    netrx(buf, &n, &len);
    ok(n);
  }
  printf("%d bytes\n", sz);
}

  
  
