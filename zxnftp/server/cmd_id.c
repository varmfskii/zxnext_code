#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "zxnftp.h"

void cmd_id(uint8_t n) {
  printf("id -> %s", ID);
  nettxln(ID, n);
}

  
  
