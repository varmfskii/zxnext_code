#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "zxnftp.h"

void cmd_ls0(uint8_t n) {
  puts("ls .");
  n=netrxln(buf);
  if (strcmp("RR", buf)) {
    nettxs("XX\n", n);
    return;
  }
  nettxs("<directory data>\n", n);
}

  
  
