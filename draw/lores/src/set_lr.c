#include "draw_lr.h"

void set_lr(UCHAR x, UCHAR y, UCHAR f) {
  /* plot a point */
  address screen;

  if (y>48) {
    y-=48;
    screen.hl.h=0x60|(y>>1);
  } else {
    screen.hl.h=0x40|(y>>1);
  }    
  screen.hl.l=(y<<7)|x;
  *(screen.a)=f;
}
