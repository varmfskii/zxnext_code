#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "zxnftp.h"

void cmd_id(uint8_t n) {
  puts("id");
  n=netrxs(buf);
  if (strcmp("RR\n", buf)) {
    nettx("XX\n", n, 3);
    return;
  }
  nettx(ID, n, strlen(ID));
}

  
  
