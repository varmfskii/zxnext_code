#include "zxnftp.h"
#include <string.h>

struct error {
  char *s, *l;
};
void srvrerr(char *err) {
  const struct error errors[] = {
				 NULL, NULL };
  int i;

  for(i=0; errors[i].s; i++) {
    if (!strcmp(errors[i].s, err)) {
      waddstr(win, errors[i].l);
      return;
    }
  }
  waddstr(win, "Unknown error\n");
}
