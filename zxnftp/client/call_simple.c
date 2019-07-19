#include "zxnftp.h"
#include <curses.h>
#include <string.h>
#include <unistd.h>

void call_simple(char *cmd, char *param, int list) {
  char buf[255];
  int i, len;

  if (sendstr(cmd)) return;
  if (param && sendstr(param)) return;
  if (list) {
    if (sendstr("RR")) return;
#ifndef NONET
    do {
      len=read(server, buf, 255);
      for(i=0; i<len; i++) waddch(win, buf[i]);
    } while (len==255);
#else
    waddstr(win, "response\n");
#endif
  }
  waddstr(win, "Ok\n");
}
