#include <stdio.h>
#include <stdint.h>
#include "zxnftp.h"

uint8_t uartread(char *buf, uint8_t n) {
  uint8_t i;

  for(i=0; i<n && (TX&UART_DATA); i++) {
    buf[i]=RX;
  }
  return i;
}
