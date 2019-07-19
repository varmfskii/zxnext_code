#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "zxnftp.h"

void cmd_get(uint8_t n) {
  n=netrxs(buf);
  printf("get %s", buf);
  // open file
  ok(n);
  n=netrxs(buf);
  if (strcmp("RR\n", buf)) {
    nettx("XX\n", n, 3);
    return;
  }
  // read from file
  // transmit block
  nettx("<file contents>\n", n, 16);
  // close file
}

  
  
