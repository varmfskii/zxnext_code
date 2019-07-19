#include "zxnftp.h"
#include "server.h"
#include <curses.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>

void call_exit(void) {
  char buf[255];

#ifdef DEBUG
  waddstr(debug, "EXIT\n");
#endif
#ifndef NONET
  write(server, "EXIT\n", 5);
  len=read(server, buf, 254);
  buf[len]='\0';
  if (!strcmp(buf, "OK\n"))
    waddstr(win, "Ok\n");
  else
    waddstr(win, "Error: unknown error\n");
#else
  waddstr(win, "Ok\n");
#endif
  finish();
  exit(0);
}
  
