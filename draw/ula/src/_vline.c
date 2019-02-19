#include "draw.h"

void _vline(UCHAR x, UCHAR y0, UCHAR y1, UCHAR f) {
  /* draw a vertical line */
  UCHAR v, y, t, xa;
  UCHAR yl;
  
  address screen;
  
  if (y0>y1) {
    t=y0; y0=y1; y1=t;
  }
  xa=x>>3;
  v=0x80>>(x&07);
  for(y=y0; y<=y1; y++) {
    screen.hl.h=(pixel_base)|((y&0300)>>3)|(y&07);
    screen.hl.l=((y&070)<<2)|xa;
    _set(screen.a, f, v);
  }
  switch(screen_mode&7) {
  case ULA:
  case ALT:
    yl=y0&0370;
    if (f&(FG|BG)) for(y=yl; y<=y1; y+=8) _setcolor(x, y, f);
    break;
  case HICOL:
    if (f&(FG|BG)) for(y=y0; y<=y1; y++) _setcolor(x, y, f);
    break;
  }
}
