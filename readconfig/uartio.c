#include <stdio.h>
#include <stdint.h>
#include "readconfig.h"

#define UART_DATA 0x01
#define UART_BUSY 0x02
#define UART_FULL 0x04

__sfr __banked __at 0x133b TX;
__sfr __banked __at 0x143b RX;

uint8_t uartread(char *buf, uint8_t n) {
  uint8_t i;

  for(i=0; i<n && (TX&UART_DATA); i++) {
    buf[i]=RX;
  }
  return i;
}

void uartwrite(char *buf, uint8_t n) {
  uint8_t i;

  for(i=0; i<n; i++) {
    while(TX&UART_BUSY);
    TX=buf[i];
  }
  while(TX&UART_BUSY);
}

