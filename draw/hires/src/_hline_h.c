#include "draw_h.h"

void _hline_h(short x1, short x2, UCHAR y, UCHAR f) {
  /* draw a horizontal line */
  address even, odd;
  UCHAR *a;
  short t;
  UCHAR x, xl, xh;
  UCHAR first, last, offset;

  /* make sure x1<=x2 */
  if (x1>x2) {
    t=x1;
    x1=x2;
    x2=t;
  }
  offset=((y&0300)>>3)|(y&07);
  even.hl.h=(B_PIXEL>>8)|offset;
  odd.hl.h=(B_ALTP>>8)|offset;
  offset=(y&070)<<2;
  xl=x1>>4;
  xh=x2>>4;
  first=last=0xff;
  /* find the values to be set in the first byte of the line */
  first>>=(x1&07);
  /* find the values to be set in the last byte of the line */
  last<<=(7-(x2&07));
  /* both ends in same byte */
  if ((x1&0770)==(x2&0770)) {
    if (x1&010) even.hl.h=odd.hl.h;
    even.hl.l=offset|xl;
    _set(even.a, f, first&last);
    return;
  }
  /* first byte */
  if (x1&010) {
    odd.hl.l=offset|xl;
    a=odd.a;
  } else {
    even.hl.l=offset|xl;
    a=even.a;
    if (xl!=xh) {
      odd.hl.l=offset|xl;
      _setbyte(odd.a, f);
    }
  }
  _set(a, f, first);
  for(x=xl+1; x<xh; x++) {
    even.hl.l=offset|x;
    odd.hl.l=offset|x;
    _setbyte(even.a, f);
    _setbyte(odd.a, f);
  }
  /* last byte */
  if (x2&010) {
    odd.hl.l=offset|xh;
    a=odd.a;
    if (xl!=xh) {
      even.hl.l=offset|xh;
      _setbyte(even.a, f);
    }
  } else {
    even.hl.l=offset|xh;
    a=even.a;
  }
  _set(a, f, last);
}
