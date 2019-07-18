#ifndef READCONFIG_H
#define READCONFIG_H
#include <stdint.h>

#define BSIZE 255
#define UART_DATA 0x01
#define UART_BUSY 0x02
#define UART_FULL 0x04
#define CONFIG "server.cfg"
#define OK 0
#define ERROR 1
#define SEND_OK 2
#define SEND_FAIL 3

#define UARTWRITES(X) uartwrite(X, strlen(X))

typedef struct file {
  unsigned char fp;
  char buf[BSIZE];
  uint8_t valid, ix;
} file;

__sfr __banked __at 0x133b TX;
__sfr __banked __at 0x143b RX;

char *netrx(uint8_t *, uint16_t *);
file *openfile(char *);
uint8_t cmdresponse(char *);
uint8_t netclose(uint8_t);
uint8_t nettx(char *, uint8_t, uint8_t);
uint8_t readline(char *, uint8_t, file *);
uint8_t startserver(void);
uint8_t uartchar(void);
uint8_t uartread(char *, uint8_t);
uint8_t uartresponse(void);
void closefile(file *);
void endserver(void);
void uartwrite(char *, uint8_t);
void work(void);
#endif
