#include <stdio.h>
#include <stdint.h>
#include "readconfig.h"

void uartwrite(char *buf, uint8_t n) {
  uint8_t i;

  for(i=0; i<n; i++) {
    while(TX&UART_BUSY);
    TX=buf[i];
  }
  while(TX&UART_BUSY);
}
