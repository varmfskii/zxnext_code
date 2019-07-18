#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "server.h"

uint8_t nettx(char *buf, uint8_t n, uint8_t len) {
  char command[19];
  uint8_t r;

  sprintf(command, "AT+CIPSEND=%d,%d\r\n", n, len);
  UARTWRITES(command);
  if (uartresponse()) return 1;
  uartwrite(buf, len);
  return uartresponse()!=2;
}
