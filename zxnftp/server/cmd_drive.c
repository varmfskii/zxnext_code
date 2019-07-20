#include <stdio.h>
#include <stdlib.h>
#include <arch/zxn/esxdos.h>
#include "zxnftp.h"

void cmd_drive(uint8_t n) {
  uint8_t r, n1;
  
  ok(n);
  n1=netrxln(buf);
  printf("drive %c\n", buf[0]);
  r=0xff;
  r=esx_dos_set_drive(buf[0]);
  if(r==0xff) {
    puts("fail");
    nettxs("NE\n", n1);
  } else {
    puts("success");
    ok(n1);
  }
}

  
  
