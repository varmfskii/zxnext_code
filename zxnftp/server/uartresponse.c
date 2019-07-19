#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "zxnftp.h"

#define LINESZ 255

uint8_t uartresponse(void) {
  uint8_t i, j;
  char line[LINESZ];
  const char *responses[]={ "OK\r", "ERROR\r", "SEND OK\r", "SEND FAIL\r", NULL };

  i=0;
  for(; i<LINESZ;)
    if ((line[i++]=uartchar())=='\n') {
      line[i-1]='\0';
      for(j=0; responses[j]; j++)
	if (!strcmp(line, responses[j])) return j;
      i=0;
    }
  fprintf(stderr, "Line length exceeded\n");
  exit(1);
  return 0xff;
}
