#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "zxnftp.h"

void cmd_get(uint8_t n) {
  n=netrxln(buf);
  printf("get %s\n", buf);
  // open file
  ok(n);
  n=netrxln(buf);
  if (strcmp("RR", buf)) {
    nettxs("XX\n", n);
    return;
  }
  // read from file
  // transmit block
  nettxs("<file contents>\n", n);
  // close file
}

  
  
