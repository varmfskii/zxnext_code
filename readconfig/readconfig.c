#include <stdio.h>
#include "myfile.h"

#define CONFIG "d:\config"
#define LINESZ 100

file *openfile(char *);
void closefile(file *);
int readline(char *, int, file *);

int main() {
  file *in;
  char line[LINESZ];
  
  if(!(in=openfile(CONFIG))) {
    fprintf(stderr, "Unable to open %s\n", CONFIG);
    return 1;
  }
  while(readline(line, LINESZ, in)) printf("[%s]\n", line);
  closefile(in);
  return 0;
}
