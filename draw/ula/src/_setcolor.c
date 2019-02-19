#include "draw.h"

void _setcolor(UCHAR x, UCHAR y, UCHAR m) {
  /* set color attribute */
  address screen;
  
  switch(screen_mode&7) {
  case ULA:
  case ALT:
    screen.hl.h=(color_base)|(y>>6);
    screen.hl.l=((y&0xF8)<<2)|(x>>3);
    break;
  case HICOL:
    screen.hl.h=(color_base)|((y&0300)>>3)|(y&07);
    screen.hl.l=((y&070)<<2)|(x>>3);
    break;
  }
  if (m&FG) {
    if (m&BG)
      *(screen.a)=ula_color;
    else
      *(screen.a)=(ula_color&0307)|(*(screen.a)&070);
  } else
    *(screen.a)=(ula_color&0370)|(*(screen.a)&07);
}
