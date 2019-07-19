#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "zxnftp.h"

void cmd_ls(uint8_t n) {
  n=netrxs(buf);
  printf("ls %s", buf);
  // open directory
  ok(n);
  n=netrxs(buf);
  if (strcmp("RR\n", buf)) {
    nettx("XX\n", n, 3);
    return;
  }
  // read from file
  // transmit block
  nettx("<directory data>\n", n, 17);
  // close file
}

  
  
