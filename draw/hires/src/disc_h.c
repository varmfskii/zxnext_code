#include "draw_h.h"


void disc_h(short xc, UCHAR yc, UCHAR r, UCHAR f) {
  /* implement brensham's circle algorithm (midpoint circle algorithm)
     from http://en.wikipedia.org/wiki/Midpoint_circle_algorithm */
  UCHAR y, dx, dy, yp;
  short err, r2, x, xp;
  
  x=xp=r-1;
  r2=-2*r;;
  y=yp=0;
  dx=dy=1;
  err=dx+r2;

  _hline_h(xc+r, xc-r, yc, f);
  y++;
  err+=dy;
  dy+=2;
  if (err>0) {
    x--;
    dx+=2;
    err+=r2+dx;
  }
  while (x>y) {
    if (xp!=x) {
      _hline_h(xc-yp, xc+yp, yc-xp, f);
      _hline_h(xc-yp, xc+yp, yc+xp, f);
      xp=x;
      yp=y;
    }
    _hline_h(xc-x, xc+x, yc-y, f);
    _hline_h(xc-x, xc+x, yc+y, f);
    y++;
    err+=dy;
    dy+=2;
    if (err>0) {
      x--;
      dx+=2;
      err+=r2+dx;
    }
  }
  _hline_h(xc-yp, xc+yp, yc-xp, f);
  _hline_h(xc-yp, xc+yp, yc+xp, f);
  if (x==y) {
    _hline_h(xc-y, xc+y, yc-x, f);
    _hline_h(xc-y, xc+y, yc+x, f);
  }
}
