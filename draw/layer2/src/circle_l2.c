#include "draw_l2.h"


void circle_l2(UCHAR xc, UCHAR yc, UCHAR r, UCHAR f) {
  /* implement brensham's circle algorithm (midpoint circle algorithm)
     from http://en.wikipedia.org/wiki/Midpoint_circle_algorithm */
  UCHAR x, y, dx, dy;
  short err, r2;
  
  x=r-1;
  r2=-2*r;;
  y=0;
  dx=dy=1;
  err=dx+r2;

  while (x>=y) {
    set_l2(xc+x, yc+y, f);
    set_l2(xc+y, yc+x, f);
    set_l2(xc-y, yc+x, f);
    set_l2(xc-x, yc+y, f);
    set_l2(xc-x, yc-y, f);
    set_l2(xc-y, yc-x, f);
    set_l2(xc+y, yc-x, f);
    set_l2(xc+x, yc-y, f);
    
    y++;
    err+=dy;
    dy+=2;
    if (err>0) {
      x--;
      dx+=2;
      err+=r2+dx;
    }
  }
}
