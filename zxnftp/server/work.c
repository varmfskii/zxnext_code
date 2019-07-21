#include <string.h>
#include <stdio.h>
#include "zxnftp.h"

typedef struct command {
  char *name;
  void (*routine)(uint8_t);
} command;

/*
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
*/

void work(void) {
  uint8_t i;

  for(;;) {
    puts("start loop");
    netrxln(buf);
    if (!strcmp("CD", buf)) {
    } else if (!strcmp("DR", buf)) {
      nettxln("OK");
      
    } else if (!strcmp("GT", buf)) {
      nettxln("OK");
      netrxln(buf);
      f=0xff;
      f=esx_f_open(buf, ESX_MODE_OPEN_EXIST|ESX_MODE_R);
      if (f==0xff) {
	nettxln("NE");
	return;
      }
      esx_f_fstat(f, &stat);
      sprintf(buf, "%d", stat.size);
      nettxln(buf);
      for(;;) {
	netrxln(buf);
	if (strcmp("RR", buff)) {
	  nettxln("XX");
	  break;
	}
	len=esx_f_read(f, buff, BLKSZ);
	printf("read: %d\n", len);
	if (!len) {
	  nettxln("OK");
	  break;
	}
	nettx(buff, len);
      }
      esx_f_close(f);
    } else if (!strcmp("ID", buf)) {
      nettxln(ID);
    } else if (!strcmp("L.", buf)) {
      nettxln("OK");
    } else if (!strcmp("LS", buf)) {
      nettxln("OK");
    } else if (!strcmp("MD", buf)) {
      nettxln("OK");
    } else if (!strcmp("PD", buf)) {
      nettxln("OK");
    } else if (!strcmp("PT", buf)) {
      nettxln("OK");
    } else if (!strcmp("RM", buf)) {
      nettxln("OK");
    } else if (!strcmp("XX", buf)) {
      nettxln("OK");
      break;
    } else {
      nettxln("UK");
    }
    puts("end loop");
  }
}
