#include <curses.h>
#include "zxnftp.h"

void cmd_ls(char **params) {
  /*
  int i;
  
  wmove(status, 0, 0);
  wdeleteln(status);
  waddstr(status, "ls(");
  for(i=1; params[i]; i++) {
    waddch(status, '(');
    waddstr(status, params[i]);
    waddch(status, ')');
  }
  waddch(status, ')');
  if (params[1] && params[2]) {
    waddstr(win, "Error: Incorrect number of arguments. ls or ls <dir>\n");
    return;
  }
  if (params[1])
    call_simple("LS", params[1], TRUE);
  else
    call_simple("L.", NULL, TRUE);
  return;
  */
}
