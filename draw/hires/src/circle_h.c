#include "draw_h.h"

void circle_h(short xc, UCHAR yc, UCHAR r, UCHAR f) {
  /* implement brensham's circle algorithm (midpoint circle algorithm)
     from http://en.wikipedia.org/wiki/Midpoint_circle_algorithm */
  UCHAR y, dx, dy;
  short err, r2, x;
  
  x=r-1;
  r2=-2*r;
  y=0;
  dx=dy=1;
  err=dx+r2;

  set_h(xc+x, yc, f);
  set_h(xc-x, yc, f);
  set_h(xc, yc+x, f);
  set_h(xc, yc-x, f);
  y++;
  err+=dy;
  dy+=2;
  if (err>0) {
    x--;
    dx+=2;
    err+=r2+dx;
  }
  while (x>y) {
    set_h(xc+x, yc+y, f);
    set_h(xc+y, yc+x, f);
    set_h(xc-y, yc+x, f);
    set_h(xc-x, yc+y, f);
    set_h(xc-x, yc-y, f);
    set_h(xc-y, yc-x, f);
    set_h(xc+y, yc-x, f);
    set_h(xc+x, yc-y, f);
    y++;
    err+=dy;
    dy+=2;
    if (err>0) {
      x--;
      dx+=2;
      err+=r2+dx;
    }
  }
  if (x==y) {
    set_h(xc+x, yc+x, f);
    set_h(xc+x, yc-x, f);
    set_h(xc-x, yc+x, f);
    set_h(xc-x, yc-x, f);
  }
}
