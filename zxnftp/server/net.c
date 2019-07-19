#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "zxnftp.h"

uint8_t netclose(uint8_t n) {
  char command[16];

  sprintf(command, "AT+CIPCLOSE=%d\r\n", n);
  return cmdresponse(command);
}

void netrx(char *rx, uint8_t *n, uint16_t *len) {
  char cbuf[16], lbuf[17];
  uint8_t i, j, rd, start;

  i=0;
  for(;;) {
    while((cbuf[i]=uartchar())!=':') i=(i+1)&0x0f;
    for(start=(i-1)&0x0f;
	cbuf[start]!='+' && cbuf[start]!=':';
	start=(start-1)&0x0f);
    for(i=0, j=(start+1)&0x0f; cbuf[j]!=':'; i++, j=(j+1)&0x0f)
      lbuf[i]=cbuf[j];
    lbuf[i]='\0';
    if (strncmp(buf, "IPD,", 4)) continue;
    if (lbuf[4]<'0' || lbuf[4]>'9') continue;
    *n=lbuf[4]-'0';
    if (lbuf[5]!=',') continue;
    for(i=6, *len=0; lbuf[i]>='0' && lbuf[i]<='9'; i++)
      *len=*len*10+lbuf[i]-'0';
    if (!lbuf[i]) break;
  }
  if (*len>BLKSZ) {
    netclose(*n);
    exit(1);
  }
  for(rd=0; rd<*len;) rd+=uartread(rx+rd, *len-rd);
}

int netrxs(char *s) {
  uint8_t n, len;
  
  netrx(s, &n, &len);
  s[len]='\0';
  return n;
}

uint8_t nettx(char *buf, uint8_t n, uint8_t len) {
  char command[19];

  sprintf(command, "AT+CIPSEND=%d,%d\r\n", n, len);
  if (cmdresponse(command)) return 1;
  uartwrite(buf, len);
  return uartresponse()!=SEND_OK;
}

void ok(uint8_t n) {
  nettx("OK\n", n, 3);
}
