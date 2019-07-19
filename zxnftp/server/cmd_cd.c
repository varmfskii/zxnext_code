#include <stdio.h>
#include <stdlib.h>
#include "zxnftp.h"

void cmd_cd(uint8_t n) {
  n=netrxs(buf);
  printf("cd %s", buf);
  ok(n);
}

  
  
