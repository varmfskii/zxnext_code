#include "zxnftp.h"

void cmd_get(char **params) {
  int i;
  
  wmove(status, 0, 0);
  wdeleteln(status);
  waddstr(status, "get(");
  for(i=1; params[i]; i++) {
    waddch(status, '(');
    waddstr(status, params[i]);
    waddch(status, ')');
  }
  waddch(status, ')');
  if (!params[1] || params[2]) {
    waddstr(win, "Error: Incorrect number of arguments. get <file>\n");
    return;
  }
  call_get(params[1]);
  return;
}
