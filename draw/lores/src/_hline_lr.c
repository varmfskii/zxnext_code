#include "draw_lr.h"

void _hline_lr(UCHAR x1, UCHAR x2, UCHAR y, UCHAR f) {
  /* draw a horizontal line */
  address screen;
  UCHAR t, x;

  if (y>=192) return;
  /* make sure x1<=x2 */
  if (x1>x2) {
    t=x1;
    x1=x2;
    x2=t;
  }
  /* find msb of address, only depends on y */
  screen.hl.h=y&0x3f;
  P_N_LAYER2=(y&0300)|3;
  for(x=x1; x<x2; x++) {
    screen.hl.l=x;
    *(screen.a)=f;
  }
  screen.hl.l=x2;
  *(screen.a)=f;
}
