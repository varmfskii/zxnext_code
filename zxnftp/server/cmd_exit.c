#include <stdio.h>
#include <stdlib.h>
#include "zxnftp.h"

void cmd_exit(uint8_t n) {
  puts("exit");
  puts("closing connection");
  netclose(n);
  puts("stopping server");
  endserver();
  puts("done");
  exit(0);
}

  
  
