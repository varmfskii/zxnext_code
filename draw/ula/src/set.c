#include "draw.h"

void set(UCHAR x, UCHAR y, UCHAR f) {
  /* plot a point */
  address screen;

  if (y>=192) return;
  /* set colors */
  if (f&(FG|BG)) _setcolor(x, y, f);
  /* address */
  screen.hl.h=(pixel_base)|((y&0300)>>3)|(y&07);
  screen.hl.l=((y&070)<<2)|(x>>3);
  /* set bit */
  _set(screen.a, f, 0x80>>(x&07));
}
