#include <stdio.h>

int main(int argc, char *argv[]) {
  FILE *in, *out;
  int i, c, v;
  
  if (argc!=3) {
    fprintf(stderr, "wrong number or arguments: %d\n", argc);
    fprintf(stderr, "Usage: %s <in> <out>\n", argv[0]);
    return 1;
  }
  if (!(in=fopen(argv[1], "r"))) {
    fprintf(stderr, "Unable to open input file \"%s\"\n", argv[1]);
    return 2;
  }
  if (!(out=fopen(argv[2], "w"))) {
    fclose(in);
    fprintf(stderr, "Unable to open output file \"%s\"\n", argv[2]);
    return 3;
  }
  for(i=0; i<32*8*4; i++) putc('\0', out);
  while((c=getc(in))!=EOF) {
    for(i=0; i<4; i++) {
      v=((c&0x80)?0xf0:0x00)|((c&0x40)?0x0f:0x00);
      c<<=2;
      putc(v, out);
    }
  }
  fclose(in);
  fclose(out);
  return 0;
}
	    
