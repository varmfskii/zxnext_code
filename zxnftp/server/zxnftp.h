#ifndef ZXNFTPS_H
#define ZXNFTPS_H
#include <stdint.h>
#include "../zxnftp.h"

#define BSIZE 255
#define UART_DATA 0x01
#define UART_BUSY 0x02
#define UART_FULL 0x04
#define CONFIG "zxnftp.cfg"
#define OK 0
#define ERROR 1
#define SEND_OK 2
#define SEND_FAIL 3
#define ID "ZXNFTP 0.1\n"

#define UARTWRITES(X) uartwrite(X, strlen(X))

typedef struct file {
  unsigned char fp;
  char buf[BSIZE];
  uint8_t valid, ix;
} file;

__sfr __banked __at 0x133b TX;
__sfr __banked __at 0x143b RX;

char *parse(char *);
file *openfile(char *);
int netrxs(char *);
uint8_t cmdresponse(char *);
uint8_t netclose(uint8_t);
uint8_t nettx(char *, uint8_t, uint8_t);
uint8_t readline(char *, uint8_t, file *);
uint8_t startserver(void);
uint8_t uartchar(void);
uint8_t uartread(char *, uint8_t);
uint8_t uartresponse(void);
void closefile(file *);
void cmd_cd(uint8_t);
void cmd_exit(uint8_t);
void cmd_get(uint8_t);
void cmd_id(uint8_t);
void cmd_ls(uint8_t);
void cmd_ls0(uint8_t);
void cmd_mkdir(uint8_t);
void cmd_put(uint8_t);
void cmd_rm(uint8_t);
void endserver(void);
void netrx(char *, uint8_t *, uint16_t *);
void ok(uint8_t);
void uartwrite(char *, uint8_t);
void work(void);

extern char buf[BLKSZ];
#endif
