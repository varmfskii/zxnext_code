#include <stdlib.h>
#include "zxnftp.h"

char *parse(char *line) {
  int i;
  char *rv=NULL;
  
  for(i=0; line[i]; i++)
    if (line[i]==' ') {
      line[i]='\0';
      if (!rv) rv=line+i+1;
    } else if (line[i]=='\r' || line[i]=='\n') {
      line[i]='\0';
      return rv;
    }
  return rv;
}
