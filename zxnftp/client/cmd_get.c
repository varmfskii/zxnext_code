#include <stdlib.h>
#include "zxnftp.h"

void cmd_get(char **params) {
  int i, len, numpar;
  char *data, *dest;
  FILE *out;
  
  wmove(status, 0, 0);
  wdeleteln(status);
  waddstr(status, "get(");
  for(i=1; params[i]; i++) {
    waddch(status, '(');
    waddstr(status, params[i]);
    waddch(status, ')');
  }
  waddch(status, ')');
  if (i<2 || i>3) {
    waddstr(win, "Error: Incorrect number of arguments. get <file> [<file>]\n");
    return;
  }
  data=call_get(params[1], &len);
  if (!data) {
    waddstr(win, "Error: no data\n");
    return;
  }
  dest=(i==2)?params[1]:params[2];
  if (!(out=fopen(dest, "w"))) {
    waddstr(win, "Error: unable to open ");
    waddstr(win, dest);
    waddch(win, '\n');
    free(data);
    return;
  }
  fwrite(data, len, 1, out);
  free(data);
  waddstr(win, "Ok\n");
  return;
}
