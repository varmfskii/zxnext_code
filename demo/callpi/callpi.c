#include <stdio.h>
#include "callpi.h"

#define LIMIT 10000

void uartwrite(char *s);
void uartprint(void);
int uarttxrx(char *s);
int uartread(void);
void writebuffer(void);

char buffer[BSIZE];
unsigned int blen;

int main() {
  NEXT_SEL=0xa0;
  NEXT_RW=0x30;
  UART_CTL=SEL_PI;
  uartread();
  if (blen) writebuffer();
  for(; uarttxrx(""); );
  while (!blen || buffer[blen-2]==':') {
    uarttxrx("alex");
    uarttxrx("killer2funk");
  }
  uarttxrx("omxplayer --no-keys bachfugue.mp3 >/dev/null&");
  for(uartread(); blen; uartread()) writebuffer();
  return 0;
}

void uartwrite(char *s) {
  int i;
  
  for(i=0; s[i]; i++) {
    while(UART_TX&UART_BUSY);
    UART_TX=s[i];
  }
}

int uartread(void) {
  unsigned long j;

  for(blen=0; blen<BSIZE-1; blen++) {
    if (!UART_TX&UART_DATA) {
      for(j=0; j<LIMIT && !UART_TX&UART_DATA; j++);
      if (j==LIMIT) break;
    }
    buffer[blen]=UART_RX;
  }
  buffer[blen]='\0';
  return blen;
}

int uarttxrx(char *s) {
  uartwrite(s);
  uartwrite("\r\n");
  for(;;) {
    if(uartread()) writebuffer();
    if (blen!=BSIZE-1) break;
  }
  return blen;
}

void writebuffer(void) {
  int i;

  for(i=0; i<blen; i++)
    if (buffer[i]) putchar(buffer[i]);
}
