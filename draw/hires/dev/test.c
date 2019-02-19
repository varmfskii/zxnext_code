#include <math.h>
#include "draw_h.h"

#define R 80.0
#define XC 255
#define YC 95
#define N 12
#define S 4

int main() {
  float pi=4*atan(1);
  float th, x[N], y[N];
  short x0, x1, y0, y1;
  UCHAR i;
  
  setmode_h();
  cls_h();
  line_h(0, 0, 511, 191, SET);
  line_h(0, 191, 511, 0, SET);
  /*
  disc_h(255, 95, 65, SET);
  circle_h(255, 95, 55, UNSET);
  for(i=0; i<N; i++) {
    th=i*pi*2.0/N;
    x[i]=(2*R*sin(th)+XC);
    y[i]=(R*cos(th)+YC);
  }
  for(x0=-20; x0<540; x0+=275)
    for(y0=-10; y0<270; y0+=105)
      for(x1=-20; x1<540; x1+=275)
	for(y1=-10; y1<270; y1+=105)
	  line_h(x0, y0, x1, y1, XSET);
  for(i=0; i<N; i++) line_h(x[i], y[i], x[(i+S)%N], y[(i+S)%N], XSET);
  */
  for(;;);
  return 0;
}
