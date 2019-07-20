#include <stdio.h>
#include <stdlib.h>
#include "zxnftp.h"

void cmd_mkdir(uint8_t n) {
  n=netrxln(buf);
  printf("mkdir %s\n", buf);
  ok(n);
}

  
  
