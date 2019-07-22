#include "zxnftp.h"
#include <unistd.h>
#include <string.h>

void netrx(char *rx, uint8_t *rlen, uint8_t mode) {
  uint8_t len;
  
  len=read(server, rx, 255);
  switch (mode) {
  case STRING:
    rx[len]='\0';
    break;
  case LINE:
    if (len>=2 && (rx[len-2]=='\n' || rx[len-2]=='\r'))
      rx[len=len-2]='\0';
    else if (len>=1 && (rx[len-1]=='\n' || rx[len-1]=='\r'))
      rx[len=len-1]='\0';
    else
      rx[len]='\0';
    break;
  default:
    *rlen=len;
  }
#ifdef DEBUG
  waddstr(debug, "read: ");
  for(int i=0; i<len; i++) waddch(debug, rx[i]);
  waddch(debug, '\n');
  wrefresh(debug);
#endif
}

void nettx(const char *buff, uint8_t len) {
  uint8_t len1;
  
  if (len=STRING || len==LINE)
    len1=strlen(buff);
  else
    len1=len;
  write(server, buff, len1);
#ifdef DEBUG
  waddstr(debug, "write: ");
  for(int i=0; i<len1; i++) waddch(debug, buff[i]);
  waddch(debug, '\n');
  wrefresh(debug);
#endif
  if (len==LINE) write(server, "\r\n", 2);
}
