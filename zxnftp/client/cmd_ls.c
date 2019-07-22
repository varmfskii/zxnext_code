#include <curses.h>
#include <string.h>
#include "zxnftp.h"

void cmd_ls(char **params) {
  uint8_t len;
  int i;
  char buf[BLKSZ];
  
  if (params[1]) {
    nettxln("LS");
    if (neterr(NULL)) return;
    nettxln(params[1]);
  } else
    nettxln("L.");
  if (neterr(NULL)) return;
  for(;;) {
    nettxln("RR");
    netrxln(buf);
    if (!strncmp("OK", buf, 2)) break;
    waddstr(win, "Attr:\n");
    waddstr(win, buf);
    netrxln(buf);
    waddstr(win, "\nName:\n");
    waddstr(win, buf);
    waddch(win, '\n');
  }
  waddstr(win, "Ok\n");
  return;
}
