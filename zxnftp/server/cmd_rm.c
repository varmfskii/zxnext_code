#include <stdio.h>
#include <stdlib.h>
#include "zxnftp.h"

void cmd_rm(uint8_t n) {
  n=netrxln(buf);
  printf("rm %s\n", buf);
  ok(n);
}

  
  
