#include <stdio.h>
#include <string.h>
#include "server.h"

#define CONFIG "config"
#define LINESZ 512

void startserver(void) {
  file *in;
  uint8_t i, j, len;
  char line[LINESZ], command[256];
  char *params[6];
  int ix=0;
  const char *fields[] =
    {
     "ip", "gateway", "mask", "ssid", "password", "port", "excess"
    };
  
  if(!(in=openfile(CONFIG))) {
    fprintf(stderr, "Unable to open %s\n", CONFIG);
    return;
  }
  for(ix=i=j=0; i<6; i++) {
    if (!(len=readline(line+ix, (LINESZ-ix)?255:(LINESZ-ix), in))) break;
    params[i]=line+ix;
    ix+=len;
  }
  closefile(in);
  puts("start server");
  // echo off
  if (cmdresponse("ATE0\r\n")) return;
  // station mode
  if(cmdresponse("AT+CWMODE=1\r\n")) return;
  // set ip address
  sprintf(command, "AT+CIPSTA=\"%s\",\"%s\",\"%s\"\r\n", params[0], params[1], params[2]);
  if (cmdresponse(command)) return;
  // connect to wifi
  sprintf(command, "AT+CWJAP=\"$s\",\"%s\"\r\n", params[3], params[4]);
  if (cmdresponse(command)) return;
  // multiplex off
  if (cmdresponse("AT+CIPMUX=1\r\n")) return;
  // start server
  sprintf(command, "AT+CIPSERVER=1,%s\r\n", params[5]);
  if (cmdresponse(command)) return;
  puts("server started");  
}
