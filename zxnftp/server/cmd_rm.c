#include <stdio.h>
#include <stdlib.h>
#include "zxnftp.h"

void cmd_rm(uint8_t n) {
  n=netrxs(buf);
  printf("rm %s", buf);
  ok(n);
}

  
  
