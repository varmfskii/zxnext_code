#include "draw_l2.h"

void disc_l2(UCHAR xc, UCHAR yc, UCHAR r, UCHAR f) {
  /* implement brensham's circle algorithm (midpoint circle algorithm)
     from http://en.wikipedia.org/wiki/Midpoint_circle_algorithm */
  UCHAR x, y, dx, dy, xp, yp;
  short err, r2;
  
  x=xp=r-1;
  r2=-2*r;;
  y=yp=0;
  dx=dy=1;
  err=dx+r2;

  while (x>=y) {
    if (xp!=x) {
      _hline_l2(xc-yp, xc+yp, yc-xp, f);
      _hline_l2(xc-yp, xc+yp, yc+xp, f);
      xp=x;
    }
    _hline_l2(xc-x, xc+x, yc-y, f);
    _hline_l2(xc-x, xc+x, yc+y, f);
    yp=y;
    y++;
    err+=dy;
    dy+=2;
    if (err>0) {
      x--;
      dx+=2;
      err+=r2+dx;
    }
  }
  if (xp!=x) {
    _hline_l2(xc-yp, xc+yp, yc-xp, f);
    _hline_l2(xc-yp, xc+yp, yc+xp, f);
  }
}
