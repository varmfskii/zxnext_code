#include <stdio.h>
#include <stdlib.h>
#include <arch/zxn/esxdos.h>
#include "zxnftp.h"

void cmd_cd(uint8_t n) {
  uint8_t r, n1;
  
  ok(n);
  n1=netrxln(buf);
  printf("cd %s\n", buf);
  r=0xff;
  r=esx_f_chdir(buf);
  if(r==0xff) {
    puts("fail");
    nettxs("NE\n", n1);
  } else {
    puts("success");
    ok(n1);
  }
}

  
  
