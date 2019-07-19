#include "zxnftp.h"
#include <curses.h>
#include <string.h>
#include <unistd.h>

void call_put(char *param) {
  char buf[BLKSZ];

#ifndef NONET
  if (!(local=fopen(param, "r"))) {
    waddstr(win, "Error: Unable to open local file: ");
    waddstr(win, param);
    waddch(win, '\n');
    return;
  }
  if (sendstr("PT")) goto terminate;
#endif
#ifdef DEBUG
  waddstr(debug, "PT");
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
  while((len=fread(buf, 1, BLKSZ, local))) {
    if (sendraw(buf, len)) goto terminate;
  }
 terminate:
  fclose(local);
#else
  waddstr(debug, "data\n");
#endif
}
  
