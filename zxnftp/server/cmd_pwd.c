#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <arch/zxn/esxdos.h>
#include "zxnftp.h"

void cmd_pwd(uint8_t n) {
  char wd[ESX_PATHNAME_MAX+1];
  
  esx_f_getcwd(wd);
  nettxln(wd, n);
  printf("pwd ->  %s\n", wd);
  return;
  /*
  ok(n);
  n=netrxln(buf);
  if (strcmp("RR", buf)) {
    nettxs("XX\n", n);
    return;
  }
  nettxln(wd, n);
  printf("WD: %s", wd);
  puts("pwd done");
  */
}

  
  
