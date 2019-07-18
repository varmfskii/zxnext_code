#include <stdio.h>
#include <stdint.h>
#include "server.h"

uint8_t uartchar(void) {
  while(!TX&UART_DATA);
  return RX;
}
