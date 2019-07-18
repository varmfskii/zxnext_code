#include <string.h>
#include "server.h"

uint8_t cmdresponse(char *cmd) {
  uartwrite(cmd, strlen(cmd));
  return uartresponse();
}
