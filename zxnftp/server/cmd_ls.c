#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "zxnftp.h"

void cmd_ls(uint8_t n) {
  n=netrxln(buf);
  printf("ls %s\n", buf);
  // open directory
  ok(n);
  n=netrxln(buf);
  if (strcmp("RR", buf)) {
    nettxs("XX\n", n);
    return;
  }
  // read from file
  // transmit block
  nettxs("<directory data>\n", n);
  // close file
}

  
  
