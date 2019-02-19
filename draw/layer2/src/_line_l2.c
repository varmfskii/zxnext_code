#include "draw_l2.h"

void _line_l2(UCHAR x0, UCHAR y0, UCHAR x1, UCHAR y1, UCHAR f) {
  /* implementation of Brensham's line algorithm */
  short d, dx, dy;
  UCHAR t, x, y, step;
  
  if (y0==y1) {
    _hline_l2(x0, x1, y0, f);
    return;
  }
  if (x0==x1) {
    _vline_l2(x0, y0, y1, f);
    return;
  }
  dx=(short) x1-(short) x0;
  dy=(short) y1-(short) y0;
  if (dx<0) dx=-dx;
  if (dy<0) dy=-dy;
  if (dx>dy) {
    if (x0>x1) {
      t=x0; x0=x1; x1=t;
      t=y0; y0=y1; y1=t;
    }
    dx=(short) x1-(short) x0;
    dy=(short) y1-(short) y0;
    y=y0;
    if (dy>0) {
      step=1;
      dy<<=1;
    } else {
      step=0xff; /* overflows as -1 */
      dy=(-dy)<<1;
    }
    d=dy-dx;
    dx=-(dx<<1);
    for(x=x0; x<x1; x++) {
      set_l2(x, y, f);
      if (d>0) {
	y+=step;
	d+=dx;
      }
      d+=dy;
    }
  } else {
    if (y0>y1) {
      t=x0; x0=x1; x1=t;
      t=y0; y0=y1; y1=t;
    }
    dx=(short) x1-(short) x0;
    dy=(short) y1-(short) y0;
    x=x0;
    if (dx>0) {
      step=1;
      dx<<=1;
    } else {
      step=0xff; /* overflows as -1 */
      dx=(-dx)<<1;
    }
    d=dx-dy;
    dy=-(dy<<1);
    for(y=y0; y<y1; y++) {
      set_l2(x, y, f);
      if (d>0) {
	x+=step;
	d+=dy;
      }
      d+=dx;
    }
  }
  set_l2(x, y, f);
}
