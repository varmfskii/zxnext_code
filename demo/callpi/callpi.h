#ifndef CALLPI_H
#define CALLPI_H
#include <stdint.h>

#define SEL_PI 0x40
#define SEL_ESP 0x00
#define BSIZE 255
#define ID "CALLPI 1.0"
#define UART_BUSY 0x02
#define UART_DATA 0x01
#define UART_FULL 0x04

__sfr __banked __at 0x133b UART_TX;
__sfr __banked __at 0x143b UART_RX;
__sfr __banked __at 0x153b UART_CTL;
__sfr __banked __at 0x243b NEXT_SEL;
__sfr __banked __at 0x253b NEXT_RW;
__sfr __at 0xff TIMEX;

inline char uartreadc(void) {
  while(!UART_TX&UART_DATA);
  return UART_RX;
}

inline void uartwritec(char c) {
  while(UART_TX&UART_BUSY);
  UART_TX=c;
}
#endif
