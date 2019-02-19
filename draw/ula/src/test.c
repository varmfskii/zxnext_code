#include <math.h>
#include "draw.h"

#define R 80.0
#define XC 127
#define YC 95
#define N 12
#define S 4

int main() {
  float pi=4*atan(1);
  float th, x[N], y[N];
  short x0, x1, y0, y1;
  UCHAR i;
  
  cls();
  ink(RED);
  paper(GREEN);
  disc(127, 95, 65, INK);
  circle(127, 95, 55, PAPER);
  for(i=0; i<N; i++) {
    th=i*pi*2.0/N;
    x[i]=(R*sin(th)+XC);
    y[i]=(R*cos(th)+YC);
  }
  for(x0=-10; x0<270; x0+=137)
    for(y0=-10; y0<270; y0+=105)
      for(x1=-10; x1<270; x1+=137)
	for(y1=-10; y1<270; y1+=105)
	  line(x0, y0, x1, y1, XSET);
  ink(BLUE);
  for(i=0; i<N; i++) line(x[i], y[i], x[(i+S)%N], y[(i+S)%N], INK);
  return 0;
}
