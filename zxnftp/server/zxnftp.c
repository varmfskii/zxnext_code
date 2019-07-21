#include <stdio.h>
#include <string.h>
#include <sys/ioctl.h>
#include <arch/zxn.h>
#include <arch/zxn/esxdos.h>
#include <errno.h>
#include "zxnftp.h"

#pragma printf="%x %s %lu %u %c %d"
char buf[BLKSZ];
char line[BLKSZ];

struct esx_stat stat;
struct esx_dirent_lfn dirent;
struct esx_dirent_slice *slice;
struct tm dt;

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
    if (!buf[0]) continue;
    if (!strcmp("CD", buf)) {
#ifdef DEBUG
      puts("cd start");
#endif
      nettxln("OK");
      netrxln(buf);
      f=0xff;
      f=esx_f_chdir(buf);
      if (f==0xff)
	nettxln("NE");
      else {
	nettxln("OK");
	printf("cd %s\n", buf);
      }
#ifdef DEBUG
      puts("cd end");
#endif
    } else if (!strcmp("DR", buf)) {
#ifdef DEBUG
      puts("drive start");
#endif
      nettxln("OK");
      netrxln(buf);
      f=0xff;
      f=esx_dos_set_drive(buf[0]);
      if (f==0xff)
	nettxln("NE");
      else {
	nettxln("OK");
	printf("drive %c\n", buf[0]);
      }
#ifdef DEBUG
      puts("drive end");
#endif
    } else if (!strcmp("GT", buf)) {
#ifdef DEBUG
      puts("get start");
#endif
      nettxln("OK");
      netrxln(buf);
      f=0xff;
      f=esx_f_open(buf, ESX_MODE_OPEN_EXIST|ESX_MODE_R);
      if (f==0xff) {
	nettxln("NE");
	continue;
      }
      esx_f_fstat(f, &stat);
      sprintf(buf, "%d", stat.size);
      nettxln(buf);
      for(;;) {
	netrxln(buf);
	if (strcmp("RR", buf)) {
	  nettxln("XX");
	  break;
	}
	len=esx_f_read(f, buf, BLKSZ);
	printf("read: %d\n", len);
	if (!len) {
	  nettxln("OK");
	  break;
	}
	nettx(buf, len);
      }
      esx_f_close(f);
#ifdef DEBUG
      puts("get end");
#endif
    } else if (!strcmp("ID", buf)) {
#ifdef DEBUG
      puts("id start");
#endif
      nettxln(ID);
#ifdef DEBUG
      puts("id end");
#endif
    } else if (!strcmp("LS", buf) || !strcmp("L.", buf)) {
#ifdef DEBUG
      puts("ls start");
#endif
      if (!strcmp("LS", buf)) {
	nettxln("OK");
	netrxln(buf);
      } else {
	esx_f_getcwd(buf);
      }
      f=0xff;
      f=esx_f_opendir_ex(buf, ESX_DIR_USE_LFN);
      if (f==0xff) {
	  nettxln("NE");
	  continue;
	}
      nettxln("OK");
      for(;;) {
	netrxln(buf);
	if (strcmp("RR", buf)) {
	  nettxln("XX");
	  break;
	}
	if (!esx_f_readdir(f, &dirent) || errno) {
	  nettxln("OK");
	  break;
	}
	nettxln(dirent.name);
	slice=esx_slice_dirent(&dirent);
	tm_from_dostm(&dt, &(slice->time));
	sprintf(buf, "%02x\n%02u/%02u/%04u\n%02u:%02u:%02u\n",
		dirent.attr, dt.tm_mday, dt.tm_mon+1, dt.tm_year+1900,
		dt.tm_hour, dt.tm_min, dt.tm_sec);
	nettxs(buf);
      }
      esx_f_close(f);
#ifdef DEBUG
      puts("ls end");
#endif
    } else if (!strcmp("MD", buf)) {
#ifdef DEBUG
      puts("mkdir start");
#endif
      nettxln("OK");
      netrxln(buf);
      f=0xff;
      f=esx_f_mkdir(buf);
      if (f==0xff)
	nettxln("XX");
      else {
	nettxln("OK");
	printf("mkdir %s\n", buf);
      }
#ifdef DEBUG
      puts("mkdir end");
#endif
    } else if (!strcmp("PD", buf)) {
#ifdef DEBUG
      puts("pwd start");
#endif
      esx_f_getcwd(buf);
      nettxln(buf);
#ifdef DEBUG
      puts("pwd end");
#endif
    } else if (!strcmp("PT", buf)) {
#ifdef DEBUG
      puts("put start");
#endif
      nettxln("OK");
#ifdef DEBUG
      puts("put end");
#endif
    } else if (!strcmp("RD", buf)) {
#ifdef DEBUG
      puts("rmdir start");
#endif
      nettxln("OK");
      netrxln(buf);
      f=0xff;
      f=esx_f_rmdir(buf);
      if (f==0xff)
	nettxln("NE");
      else {
	nettxln("OK");
	printf("rmdir %s\n", buf);
      }
#ifdef DEBUG
      puts("mkdir end");
#endif
    } else if (!strcmp("RM", buf)) {
#ifdef DEBUG
      puts("rm start");
#endif
      nettxln("OK");
      netrxln(buf);
      f=0xff;
      f=esx_f_unlink(buf);
      if (f==0xff)
	nettxln("NE");
      else {
	nettxln("OK");
	printf("rm %s\n", buf);
      }
#ifdef DEBUG
      puts("rm end");
#endif
    } else if (!strcmp("XX", buf)) {
#ifdef DEBUG
      puts("exit start");
#endif
      nettxln("OK");
      break;
    } else {
      puts("unknown command");
      nettxln("UK");
    }
  }
  cmdresponse("AT+CIPCLOSE=0\r\n");
  cmdresponse("ATE1\r\n");
  puts("server done");
  return 0;
}
