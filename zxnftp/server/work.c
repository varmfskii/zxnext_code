#include <string.h>
#include <stdio.h>
#include "zxnftp.h"

typedef struct command {
  char *name;
  void (*routine)(uint8_t);
} command;

command commands[]={
		    { "CD", cmd_cd },
		    { "DR", cmd_drive },
		    { "GT", cmd_get },
		    { "ID", cmd_id },
		    { "L.", cmd_ls0 },
		    { "LS", cmd_ls },
		    { "MD", cmd_mkdir },		
		    { "PD", cmd_pwd },
		    { "PT", cmd_put },
		    { "RM", cmd_rm },
		    { "XX", cmd_exit },
		    { NULL, NULL }};

void work(void) {
  uint8_t n, i;

  for(;;) {
    puts("start loop");
    n=netrxln(buf);
    for(i=0; commands[i].name && strcmp(commands[i].name, buf); i++);
    if (!commands[i].name) {
      nettx("UK\n", n, 3);
      continue;
    }
    commands[i].routine(n);
    puts("end loop");
  }
}
