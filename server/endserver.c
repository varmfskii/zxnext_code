#include <stdio.h>
#include <string.h>
#include "readconfig.h"

void endserver(void) {
  // end server
  uartwrite("AT+CIPSERVER=0\r\n", 16);
  if (uartresponse()) return;
  // echo on
  uartwrite("ATE1\r\n", 6); 
  if (uartresponse()) return;
}
