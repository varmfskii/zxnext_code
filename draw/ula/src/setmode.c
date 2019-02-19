#include <z80.h>
#include "draw.h"

void setmode(UCHAR m) {
  if ((m&SM_MASK) != LAYER2) {
    P_TIMEXULA=0x40|(m&SM_MASK);
  }
  screen_mode=m;
  switch(screen_mode&7) {
  case ULA:
    pixel_base=B_PIXEL>>8;
    color_base=B_COLOR>>8;
    break;
  case ALT:
    pixel_base=B_ALTP>>8;
    color_base=B_ALTC>>8;
    break;
  case HICOL:
    pixel_base=B_PIXEL>>8;
    color_base=B_ALTP>>8;
    break;
  }
}
