#include <string.h>
#include "zxnftp.h"

uint8_t cmdresponse(char *cmd) {
  uartwrite(cmd, strlen(cmd));
  return uartresponse();
}
