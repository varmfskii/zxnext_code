#include "zxnftp.h"
#include "server.h"
#include <curses.h>
#include <string.h>
#include <unistd.h>

void call_mkdir(char *param) {
  char buf[255];

  sprintf(buf, "MKDIR %s\n", param);
#ifdef DEBUG
  waddstr(debug, buf);
#endif
#ifndef NONET
  write(server, buf, strlen(buf));
  len=read(server, buf, 254);
  buf[len]='\0';
  if (!strcmp(buf, "OK\n"))
    waddstr(win, "Ok\n");
  else if (!strcmp(buf, "EX\n"))
    waddstr(win, "Error: directory existsn");
  else
    waddstr(win, "Error: unknown error\n");
#else
  waddstr(win, "Ok\n");
#endif
}
  
