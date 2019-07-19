#include "zxnftp.h"
#include <curses.h>
#include <string.h>
#include <unistd.h>

void call_get(char *param) {
  char buf[BLKSZ];

#ifndef NONET
  if (!(local=fopen(param, "w"))) {
    waddstr(win, "Error: Unable to open local file: ");
    waddstr(win, param);
    waddch(win, '\n');
    return;
  }
  if (sendstr("GT")) goto terminate;
#endif
#ifdef DEBUG
  waddstr(debug, "GT");
  waddch(debug, '\n');
#endif
#ifndef NONET
  if (sendstr(param)) goto terminate;
#endif
#ifdef DEBUG
  waddstr(debug, param);
  waddch(debug, '\n');
#endif
#ifndef NONET
  while((len=read(server, buf, BLKSZ))) {
    fwrite(buf, 1, len, local);
    if (sendstr("RR")) goto terminate;
  }
 terminate:
  fclose(local);
#endif
}
  
