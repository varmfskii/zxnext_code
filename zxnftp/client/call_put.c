#include "zxnftp.h"
#include "server.h"
#include <curses.h>
#include <string.h>
#include <unistd.h>

void call_put(char *param) {
  char outbuf[255];

  if (param)
    sprintf(outbuf, "PUT %s\n", param);
  else
    strcpy(outbuf, "PUT\n");
#ifdef DEBUG
  waddstr(debug, outbuf);
#endif
#ifndef NONET
  write(server, outbuf, strlen(outbuf));
#endif
}
  
