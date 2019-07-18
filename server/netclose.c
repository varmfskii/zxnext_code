#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "server.h"

uint8_t netclose(uint8_t n) {
  char command[16];

  sprintf(command, "AT+CIPCLOSE=%d\r\n", n);
  UARTWRITES(command);
  return uartresponse();
}
