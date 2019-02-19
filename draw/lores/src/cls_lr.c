#include "draw_lr.h"

void cls_lr(UCHAR c) {
  /* clear screen, set all values to 0 */
  short *p, v;
  UCHAR pg;
  
  v=(((short) c)<<8)|c;
  for(pg=0; pg<3; pg++) {
    P_N_LAYER2=(pg<<6)|0x03;
    for(p=0; (short) p<0x4000; p++) *p=v;
  }
}
