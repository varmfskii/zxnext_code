#include <stdint.h>

#define BSIZE 255
#define UARTWRITES(X) uartwrite(X, strlen(X))

typedef struct file {
  unsigned char fp;
  char buf[BSIZE];
  uint8_t valid, ix;
} file;

file *openfile(char *);
uint8_t printresponse(void);
uint8_t readline(char *, uint8_t, file *);
uint8_t uartread(char *, uint8_t);
void closefile(file *);
void endserver(void);
void startserver(void);
void uartwrite(char *, uint8_t);
