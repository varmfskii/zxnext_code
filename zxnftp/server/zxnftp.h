#ifndef ZXNFTPS_H
#define ZXNFTPS_H
#include <stdint.h>
#include "../zxnftp.h"

#define BSIZE 255
#define CONFIG "zxnftp.cfg"
#define ERROR 1
#define ID "ZXNFTP 0.1"
#define LINE 0xff
#define OK 0
#define SEND_FAIL 3
#define SEND_OK 2
#define STRING 0
#define UARTWRITES(X) uartwrite(X, strlen(X))
#define UART_BUSY 0x02
#define UART_DATA 0x01
#define UART_FULL 0x04
#define netrxln(X) netrx((X), NULL, (LINE))
#define netrxs(X) netrx((X), NULL, (STRING))
#define nettxln(X) nettx((X), (LINE))
#define nettxs(X) nettx((X), (STRING))
#define netclose() cmdresponse("AT+CIPCLOSE=0\r\n")

void uartwrite(const char *, uint8_t);
uint8_t uartresponse(void);
void nettx(const char *, uint8_t);
void netrx(char *, uint16_t *, uint8_t);
uint8_t cmdresponse(char *);
uint8_t uartchar(void);

__sfr __banked __at 0x133b TX;
__sfr __banked __at 0x143b RX;

extern char buf[BLKSZ];
#endif
