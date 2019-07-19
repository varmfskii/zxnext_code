#include <stdio.h>
#include <stdlib.h>
#include "zxnftp.h"

void cmd_mkdir(uint8_t n) {
  n=netrxs(buf);
  printf("mkdir %s", buf);
  ok(n);
}

  
  
