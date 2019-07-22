#ifndef ZXNFTP_H
#define ZXNFTP_H
#include <curses.h>

#ifdef NONET
#define DEBUG
#endif

#define NUMERIC 0
#define STRING 0xff
#define LINE 0xfe
#define RAW 0xfd
#define BLKSZ 200
#define netrxln(X) netrx((X), NULL, (LINE))
#define netrxs(X) netrx((X), NULL, (STRING))
#define nettxln(X) nettx((X), (LINE))
#define nettxs(X) nettx((X), (STRING))

typedef struct command {
  char *name;
  void (*routine)(char **);
  char *use;
} command;

typedef struct string {
  char *data;
  int len;
} string;

struct neterr {
  char *s, *l;
};

extern WINDOW *win, *status;
#ifdef DEBUG
extern WINDOW *debug;
#endif
extern int server, w, h, disp_mode;
extern command commands[];
#ifdef NONET
extern unsigned char mem[];
#endif

int neterr(void);
char **parse(char *);
int sendraw(char *, int);
int sendstr(char *);
void backspace(WINDOW *);
void error(char *, int);
void execute(char *);
void finish(void);
void init(void);
void puthex(WINDOW *, int);
void srvrerr(char *);
void netrx(char *, uint8_t *, uint8_t);
void nettx(const char *, uint8_t);

void call_get(char *);
void call_id();
void call_put(char *);
void call_simple(char *, char *);

void cmd_cd(char **);
void cmd_exit(char **);
void cmd_get(char **);
void cmd_help(char **);
void cmd_ls(char **);
void cmd_mget(char **);
void cmd_mkdir(char **);
void cmd_mput(char **);
void cmd_put(char **);
void cmd_pwd(char **);
void cmd_quit(char **);
void cmd_rm(char **);
void cmd_rmdir(char **);

extern char *id;
extern char *addr;
extern int port;
#endif
