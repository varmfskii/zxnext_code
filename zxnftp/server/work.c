#include <string.h>
#include "zxnftp.h"

typedef struct command {
  char *name;
  void (*routine)(uint8_t);
} command;

command commands[]={
		    { "CD\n", cmd_cd },
		    { "GT\n", cmd_get },
		    { "ID\n", cmd_id },
		    { "L.\n", cmd_ls0 },
		    { "LS\n", cmd_ls },
		    { "MD\n", cmd_mkdir },
		    { "PD\n", cmd_put },
		    { "RM\n", cmd_rm },
		    { "XX\n", cmd_exit },
		    { NULL, NULL }};

void work(void) {
  uint8_t n, i;

  for(;;) {
    n=netrxs(buf);
    for(i=0; commands[i].name && !strcmp(commands[i].name, buf); i++);
    if (!commands[i].name) {
      nettx("UK\n", n, 3);
      continue;
    }
    commands[i].routine(n);
  }
}
