#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "zxnftp.h"

uint8_t nettx(char *buf, uint8_t n, uint8_t len) {
  char command[19];

  sprintf(command, "AT+CIPSEND=%d,%d\r\n", n, len);
  if (cmdresponse(command)) return 1;
  uartwrite(buf, len);
  return uartresponse()!=SEND_OK;
}
