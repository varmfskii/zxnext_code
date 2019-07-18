#include <stdio.h>
#include <string.h>
#include "server.h"

void endserver(void) {
  // end server
  cmdresponse("AT+CIPSERVER=0\r\n");
  // echo on
  cmdresponse("ATE1\r\n"); 
}
