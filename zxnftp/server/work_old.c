#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "zxnftp.h"

void work(void) {
  char *msg, *para;
  uint8_t n;
  uint16_t len, i;
  const char *cmds[]={ "EXIT", "LS", "CD", "GET", "PUT", "PWD", NULL };
  for(;;) {
    msg=netrx(&n, &len);
    para=parse(msg);
    for(i=0; cmds[i]; i++)
      if (!strcmp(cmds[i], msg)) break;
    switch(i) {
    case 0:
      nettx("EXIT\n", n, 5);
      puts("closing server");
      netclose(n);
      return;
    case 1:
      fputs("LS", stdout);
      if (para) {
	putchar(' ');
	puts(para);
      } else
	putchar('\n');
      ok(n);
      break;
    case 2:
      fputs("CD", stdout);
      if (para) {
	putchar(' ');
	puts(para);
      } else
	putchar('\n');
      ok(n);
      break;
    case 3:
      fputs("GET", stdout);
      if (para) {
	putchar(' ');
	puts(para);
      } else
	putchar('\n');
      ok(n);
      break;
    case 4:
      fputs("PUT", stdout);
      if (para) {
	putchar(' ');
	puts(para);
      } else
	putchar('\n');
      ok(n);
      break;
    case 5:
      fputs("PWD", stdout);
      if (para) {
	putchar(' ');
	puts(para);
      } else
	putchar('\n');
      ok(n);
      break;
    default:
      puts("UNKNOWN");
      nettx("UNKNOWN\n", n, 6);
      break;
    }
    free(msg);
  }
}
