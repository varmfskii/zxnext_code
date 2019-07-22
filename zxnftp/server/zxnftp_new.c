#include <stdio.h>
#include <string.h>
#include <sys/ioctl.h>
#include <arch/zxn.h>
#include <arch/zxn/esxdos.h>
#include <errno.h>
#include "zxnftp_new.h"

struct cmd {
  const char *name;
  void (*fn)(void);
};

char buf[BLKSZ];
char line[BLKSZ];
struct cmd cmds[]={
		   { "CD", cmd_cd },
		   { "DR", cmd_drive },
		   { "GT", cmd_get },
		   { "ID", cmd_id },
		   { "L.", cmd_l_ },
		   { "LS", cmd_ls },
		   { "MD", cmd_mkdir },
		   { "PD", cmd_pwd },
		   { "PT", cmd_put },
		   { "QU", cmd_quit },
		   { "RD", cmd_rmdir },
		   { "RM", cmd_rm },
		   { "XX", cmd_exit },
		   { NULL, NULL }};

int main() {
  uint8_t f, i, j, len;

  puts("ZX Spectrum Next ZXNFTP server");
  ioctl(1, IOCTL_OTERM_PAUSE, 0);
  puts("starting server");
  f=0xff;
  if ((f=esx_f_open(CONFIG, ESX_MODE_OPEN_EXIST|ESX_MODE_R))==0xff) {
    fprintf(stderr, "Unable to open %s\n", CONFIG);
    return 1;
  }
  i=0;
  for(;;) {
    if (!(len=esx_f_read(f, buf,  BLKSZ))) break;
    for(j=0; j<len; j++) 
      if (buf[j]=='\n' || buf[j]=='\r') {
	line[i++]='\r';
	line[i++]='\n';
	line[i]='\0';
	uartwrite(line, i);
	if (uartresponse()!=OK) {
	  line[i-2]='\0';
	  printf("Command failed: %s\n", line);
	  return 1;
	}
	i=0;
      } else
	line[i++]=buf[j];
  }
  esx_f_close(f);
  puts("server started");
  for(;;) {
    netrxln(buf);
    for(i=0; cmds[i].name; i++)
      if (!strcmp(cmds[i].name, buf)) {
	//puts(cmds[i].name);
	cmds[i].fn();
	break;
      }
    if (!cmds[i].name) {
      puts("unknown command");
      nettxln("UK");
    }
  }
  return 0;
}
