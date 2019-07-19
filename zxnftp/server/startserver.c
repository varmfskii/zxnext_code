#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <arch/zxn.h>
#include <arch/zxn/esxdos.h>
#include "zxnftp.h"

#define LINESZ 255

uint8_t startserver(void) {
  file *in;
  uint8_t len, f;
  char line[LINESZ];
  int ix=0;

  f=0xff;
  if ((f=esx_f_open(CONFIG, ESX_MODE_OPEN_EXIST|ESX_MODE_R))==0xff
      || !(in=(file *)malloc(sizeof(file)))) {
    fprintf(stderr, "Unable to open %s\n", CONFIG);
    return 1;
  }
  in->fp=f;
  in->valid=in->ix=0;
  for(;;) {
    if (!(len=readline(line, (uint8_t)(LINESZ-3), in))) break;
    line[len-1]='\r';
    line[len]='\n';
    line[len+1]='\0';
    if (cmdresponse(line)!=OK) {
      line[len]='\0';
      fprintf(stderr, "failed command: %s\n", line);
      return 1;
    }
  }
  esx_f_close(in->fp);
  free(in);
  return 0;
}
