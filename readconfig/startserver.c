#include <stdio.h>
#include <string.h>
#include "readconfig.h"

#define CONFIG "config"
#define LINESZ 512

void startserver(void) {
  file *in;
  uint8_t i, j, l;
  char line[LINESZ];
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
    if (!(l=readline(line+ix, (LINESZ-ix)?255:(LINESZ-ix), in))) break;
    params[i]=line+ix;
    ix+=l;
    printf("%s: [%s]\n", fields[i], params[i]);
  }
  closefile(in);
  puts("start server");
  // echo off
  uartwrite("ATE0\r\n", 6); 
  if (printresponse()) return;
  // station mode
  uartwrite("AT+CWMODE=1\r\n", 13);
  if (printresponse()) return;
  // set ip address
  uartwrite("AT+CIPSTA=\"", 11);
  UARTWRITES(params[0]);
  uartwrite("\",\"", 3);
  UARTWRITES(params[1]);
  uartwrite("\",\"", 3);
  UARTWRITES(params[2]);
  uartwrite("\"\r\n", 3);
  if (printresponse()) return;
  // connect to wifi
  uartwrite("AT+CWJAP=\"", 10);
  UARTWRITES(params[3]);
  uartwrite("\",\"", 3);
  UARTWRITES(params[4]);
  uartwrite("\"\r\n", 3);
  if (printresponse()) return;
  // multiplex off
  uartwrite("AT+CIPMUX=1\r\n", 13);
  if (printresponse()) return;
  // server at port
  //uartwrite("AT+CIPSERVERMAXCONN=1\r\n", 23);
  //if (printresponse()) return;
  uartwrite("AT+CIPSERVER=1,", 15);
  UARTWRITES(params[5]);
  uartwrite("\r\n", 2);
  if (printresponse()) return;
  // echo on
  uartwrite("ATE1\r\n", 6); 
  if (printresponse()) return;
}
