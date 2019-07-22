#include <stdint.h>
#include <stdio.h>
#include "zxnftp.h"

void senderr(void);

void cmd_simple(const char *name, uint8_t (*fn)(char *)) {
  uint8_t f;
  
  nettxln("OK");
  netrxln(buf);
  f=0xff;
  f=fn(buf);
  if (f==0xff)
    senderr();
  else {
    printf("%s %s\n", name, buf);
    nettxln("OK");
  }
}
