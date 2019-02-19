#include "draw_h.h"

void _vline_h(short x, UCHAR y0, UCHAR y1, UCHAR f) {
  /* draw a vertical line */
  UCHAR base, xa, v, y, t;
  address screen;
  
  if (y0>y1) {
    t=y0; y0=y1; y1=t;
  }
  if (x&0x08)
    base=B_ALTP>>8;
  else
    base=B_PIXEL>>8;
  xa=x>>4;
  v=0x80>>(x&07);
  for(y=y0; y<=y1; y++) {
    screen.hl.h=base|((y&0300)>>3)|(y&07);
    screen.hl.l=((y&070)<<2)|xa;
    _set(screen.a, f, v);
  }
}
