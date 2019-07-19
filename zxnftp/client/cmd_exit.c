#include <curses.h>
#include "zxnftp.h"

void cmd_exit(char **params) {
  int i;
  
  wmove(status, 0, 0);
  wdeleteln(status);
  waddstr(status, "exit(");
  for(i=1; params[i]; i++) {
    waddch(status, '(');
    waddstr(status, params[i]);
    waddch(status, ')');
  }
  waddch(status, ')');
  if (params[1]) {
    waddstr(win, "Error: Incorrect number of arguments. exit\n");
    return;
  }
  call_exit();
  return;
}
