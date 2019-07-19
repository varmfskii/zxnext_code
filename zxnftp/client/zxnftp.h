#ifndef CLIENT_H
#define CLIENT_H
#include <curses.h>

#ifdef NONET
#define DEBUG
#endif

#define PORT 8080
#define NUMERIC 0

typedef struct command {
  char *name;
  void (*routine)(char **);
  char *use;
} command;

typedef struct string {
  char *data;
  int len;
} string;

extern WINDOW *win, *status;
#ifdef DEBUG
extern WINDOW *debug;
#endif
extern int server, w, h, disp_mode;
extern command commands[];
#ifdef NONET
extern unsigned char mem[];
#endif

char **parse(char *);
void backspace(WINDOW *);
void error(char *, int);
void execute(char *);
void finish(void);
void init(void);
void puthex(WINDOW *, int);

void call_cd(char *);
void call_mkdir(char *);
void call_exit(void);

void cmd_mkdir(char **);
void cmd_cd(char **);
void cmd_get(char **);
void cmd_help(char **);
void cmd_put(char **);
void cmd_mget(char **);
void cmd_mput(char **);
void cmd_exit(char **);
void cmd_pwd(char **);
void cmd_ls(char **);
#endif
