#include "zxnftp.h"
#include <curses.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>

int sendraw(char *s, int len) {
  int i;
  char buf[BLKSZ+1];
  
#ifdef DEBUG
  for(i=0; i<len; i++) waddch(debug, s[i]);
#endif
#ifndef NONET
  write(server, s, len);
  len=read(server, buf, BLKSZ);
  buf[len]='\0';
  if (!strcmp(buf, "OK\n")) return 0;
  waddstr(win, "Error: ");
  error(buf);
  return 1;
#else
  return 0;
#endif
}
  
