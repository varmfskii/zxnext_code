#include "zxnftp.h"
#include <stdlib.h>

void error(char *err, int num) {
  finish();
  fprintf(stderr, "%s\n", err);
  exit(num);
}
