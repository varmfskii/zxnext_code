#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <arch/zxn.h>
#include <arch/zxn/esxdos.h>
#include "zxnftp.h"

struct esx_stat stat;
struct esx_dirent_lfn dirent;
struct esx_dirent_slice *slice;
struct tm dt;
struct esx_stat stat;
uint8_t f, len;

void cmd_simple(const char *name, uint8_t (*fn)(char *)) {
  nettxln("OK");
  netrxln(buf);
  f=0xff;
  f=fn(buf);
  if (f==0xff)
    senderr();
  else {
    printf("%s %s\n", name, buf);
    nettxln("OK");
  }
}

void cmd_cd(void) {
  cmd_simple("cd", esx_f_chdir);
}

void cmd_drive(void) {
  nettxln("OK");
  netrxln(buf);
  f=0xff;
  f=esx_dos_set_drive(buf[0]);
  if (f==0xff)
    senderr();
  else {
    nettxln("OK");
    printf("drive %c\n", buf[0]);
  }
}

void cmd_get(void) {
  nettxln("OK");
  netrxln(buf);
  f=0xff;
  f=esx_f_open(buf, ESX_MODE_OPEN_EXIST|ESX_MODE_R);
  if (f==0xff) {
    senderr();
    return;
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
}

void cmd_id(void) {
  nettxln(ID);
}

void do_ls(void) {
  f=0xff;
  f=esx_f_opendir_ex(buf, ESX_DIR_USE_LFN);
  if (f==0xff) {
    senderr();
    return;
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
}

void cmd_l_(void) {
  esx_f_getcwd(buf);
  do_ls();
}

void cmd_ls(void) {
  nettxln("OK");
  netrxln(buf);
  do_ls();
}

void cmd_mkdir(void) {
  cmd_simple("mkdir", esx_f_mkdir);
}

void cmd_pwd(void) {
  esx_f_getcwd(buf);
  nettxln(buf);
}

void cmd_put(void) {
  nettxln("OK");
}

void cmd_quit(void) {
  nettxln("OK");
  cmdresponse("AT+CIPCLOSE=0\r\n");
  cmdresponse("AT+CIPSERVER=0\r\n");
  cmdresponse("ATE1\r\n");
  puts("server done");
  exit(0);
}

void cmd_rmdir(void) {
  cmd_simple("rmdir", esx_f_rmdir);
}

void cmd_rm(void) {
  cmd_simple("rm", esx_f_unlink);
}

void cmd_exit(void) {
  nettxln("OK");
  cmdresponse("AT+CIPCLOSE=0\r\n");
}
