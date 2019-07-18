#include <stdlib.h>
#include <arch/zxn.h>
#include <arch/zxn/esxdos.h>
#include "server.h"

void closefile(file *f) {
  esx_f_close(f->fp);
  free(f);
}
