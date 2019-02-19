#include "draw.h"

void _hline(UCHAR x1, UCHAR x2, UCHAR y, UCHAR f) {
  /* draw a horizontal line */
  address screen;
  UCHAR t, xl, xh, ll, lh, l, first, last, x;

  if (y>=192) return;
  /* make sure x1<=x2 */
  if (x1>x2) {
    t=x1;
    x1=x2;
    x2=t;
  }
  /* find msb of address, only depends on y */
  screen.hl.h=(pixel_base)|((y&0300)>>3)|(y&07);
  xl=x1>>3;
  xh=x2>>3;
  first=last=0xff;
  /* find the values to be set in the first byte of the line */
  first>>=x1&07;
  /* find the values to be set in the last byte of the line */
  last<<=(7-(x2&07));
  /* address portion of first and last pixel */
  if (xl==xh) {
    /* both ends are in the same byte */
    screen.hl.l=((y&070)<<2)|xl;
    _set(screen.a, f, first&last);
  }
  screen.hl.l=((y&070)<<2)|xl;
  _set(screen.a, f, first);
  for(x=xl+1; x<xh; x++) {
    screen.hl.l=screen.hl.l=((y&070)<<2)|x; 
    _setbyte(screen.a, f);
  }
  screen.hl.l=((y&070)<<2)|xh;
  _set(screen.a, f, last);
}
