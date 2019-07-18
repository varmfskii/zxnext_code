#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "server.h"

char *netrx(uint8_t *n, uint16_t *len) {
  char cbuf[16], buf[17], *rv;
  uint8_t i, j, l, start;

  i=0;
  for(;;) {
    while((cbuf[i]=uartchar())!=':') i=(i+1)&0x0f;
    for(start=(i-1)&0x0f; cbuf[start]!='+' && cbuf[start]!=':'; start=(start-1)&0x0f);
    for(i=0, j=(start+1)&0x0f; cbuf[j]!=':'; i++, j=(j+1)&0x0f) buf[i]=cbuf[j];
    buf[i]='\0';
    if (strncmp(buf, "IPD,", 4)) continue;
    if (buf[4]<'0' || buf[4]>'9') continue;
    *n=buf[4]-'0';
    if (buf[5]!=',') continue;
    for(i=6, *len=0; buf[i]>='0' && buf[i]<='9'; i++) *len=*len*10+buf[i]-'0';
    if (!buf[i]) break;
  }
  rv=malloc(*len);
  for(l=0; l<*len;) l+=uartread(rv+l, (*len-l>255)?255:(*len-l));
  return rv;
}
