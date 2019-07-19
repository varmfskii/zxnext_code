#include "zxnftp.h"
#include "server.h"
#include <curses.h>
#include <string.h>
#include <unistd.h>

void call_pwd(void) {
#ifdef DEBUG
  waddstr(debug, "PWD\n");
#endif
#ifndef NONET
  write(server, "PWD\n", 4);
#endif
}
  
