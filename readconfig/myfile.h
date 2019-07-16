#define BSIZE 256

typedef struct file {
  unsigned char fp;
  char buf[BSIZE];
  int valid, ix;
} file;

file *openfile(char *);
int readline(char *, int, file *);
void closefile(file *);
