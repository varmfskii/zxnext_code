#include "zxnftp.h"

void cmd_help(char **params) {
  if (!params[1]) {
    waddstr(win, "Available commands are:\n");
    waddstr(win,"help [<command>]\n");
    return;
  }
  if (params[2]) {
    waddstr(win, "Error: incorrect number of parameters. help [<command>]\n");
    return;
  }
  // send command exit
  // rx ok
  // quit
  return;
}
