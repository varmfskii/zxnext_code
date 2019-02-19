#include "draw_lr.h"

void _vline_lr(UCHAR x, UCHAR y0, UCHAR y1, UCHAR f) {
  /* draw a vertical line */
  address screen;
  UCHAR y, ylim;
  
  screen.hl.l=x;
  y=y0;
  for(; y<=y1; ) {
    P_N_LAYER2=(y&0300)|03;
    ylim=y|077;
    for(; y<=ylim && y<=y1; y++) {
      screen.hl.h=y&077;
      *(screen.a)=f;
    }
  }
}
