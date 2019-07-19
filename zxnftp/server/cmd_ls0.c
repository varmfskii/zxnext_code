#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "zxnftp.h"

void cmd_ls0(uint8_t n) {
  puts("ls .");
  n=netrxs(buf);
  if (strcmp("RR\n", buf)) {
    nettx("XX\n", n, 3);
    return;
  }
  nettx("<directory data>\n", n, 17);
}

  
  
