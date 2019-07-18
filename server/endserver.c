#include <stdio.h>
#include <string.h>
#include "server.h"

void endserver(void) {
  // end server
  if (cmdresponse("AT+CIPSERVER=0\r\n")) return;
  // echo on
  if (cmdresponse("ATE1\r\n")) return; 
}
