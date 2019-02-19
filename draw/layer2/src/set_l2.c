#include "draw_l2.h"

void set_l2(UCHAR x, UCHAR y, UCHAR f) {
  /* plot a point */
  address screen;

  screen.hl.h=y&0x3f;
  screen.hl.l=x;
  P_N_LAYER2=(y&0300)|3;
  *(screen.a)=f;
}
