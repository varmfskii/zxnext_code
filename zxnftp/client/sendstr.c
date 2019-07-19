#include "zxnftp.h"
#include <curses.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>

int sendstr(char *s) {
  char buf[BLKSZ];
  int len=strlen(s);
  
  if (len>=BLKSZ) {
    waddstr(win, "Error: string too long\n");
    return 1;
  }
  memcpy(buf, s, len);
  buf[len]='\n';
  return sendraw(buf, len+1);
}
  
