#include <stdio.h>
#include <string.h>
#include "readconfig.h"

uint8_t printresponse(void) {
  uint8_t l, done, i, j, cr;
  char buffer[256], line[256];
  
  for(i=done=cr=0; !done; ) 
    while(l=uartread(buffer, 255)) {
      for(j=0; j<l; j++)
	switch(buffer[j]) {
	case '\r':
	  cr=1;
	  break;
	case '\n':
	  if (cr) {
	    line[i]='\0';
	    i=0;
	    puts(line);
	    if (!strcmp(line, "OK"))
	      done=1;
	    else if (!strcmp(line, "ERROR"))
	      done=2;
	  } else {
	    line[i++]='\n';
	  }
	  break;
	default:
	  cr=0;
	  line[i++]=buffer[j];
	}
    }
  line[i]='\0';
  puts(line);
  return done-1;
}
