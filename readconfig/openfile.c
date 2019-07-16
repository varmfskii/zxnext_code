#include <stdlib.h>
#include <arch/zxn.h>
#include <arch/zxn/esxdos.h>
#include "myfile.h"

file *openfile(char *fn) {
  unsigned char f=0xff;
  file *rv;
  
  if ((f=esx_f_open(fn, ESX_MODE_OPEN_EXIST|ESX_MODE_R))==0xff)
    return NULL;
  if(!(rv=(file *)malloc(sizeof(file))))
    return NULL;
  rv->fp=f;
  rv->valid=rv->ix=0;
  return rv;
}
