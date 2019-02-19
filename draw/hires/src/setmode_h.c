#include "draw_h.h"

void setmode_h(void) {
  P_TIMEXULA=0x40|(HIRES&SM_MASK);
}
