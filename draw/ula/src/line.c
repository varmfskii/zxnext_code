#include "draw.h"

#define LEFT 1
#define RIGHT 2
#define ABOVE 4
#define BELOW 8

static UCHAR outcode(short x, short y);

void line(short x0, short y0, short x1, short y1, UCHAR f) {
  /* clipped line using Cohen-Sutherland algorithm */
  short x, y, dy, dx;
  UCHAR code, code0, code1;

  code0=outcode(x0, y0);
  code1=outcode(x1, y1);
  /* line all out of region */
  if (code0 & code1) return;
  x=y=0;
  dy=y1-y0;
  dx=x1-x0;
  for(;;) {
    /* line all in region */
    if (!(code0 || code1)) {
      _line((UCHAR) x0, (UCHAR) y0, (UCHAR) x1, (UCHAR) y1, f);
      return;
    }
    code=code0?code0:code1;
    if (code&ABOVE) {
      x=x0+dx*(YMIN-y0)/dy;
      y=YMIN;
    } else if (code&BELOW) {
      x=x0+dx*(YMAX-y0)/dy;
      y=YMAX;
    } else if (code&RIGHT) {
      x=XMAX;
      y=y0+dy*(XMAX-x0)/dx;
    } else if (code&LEFT) {
      x=XMIN;
      y=y0+dy*(XMIN-x0)/dx;
    }
    if (code==code0) {
      x0=x;
      y0=y;
      code0=outcode(x0, y0);
    } else {
      x1=x;
      y1=y;
      code1=outcode(x1, y1);
    }
  }
}

static UCHAR outcode(short x, short y) {
  int code=0;

  if (x<XMIN)
    code=LEFT;
  else if (x>XMAX)
    code=RIGHT;
  if (y<YMIN)
    code|=ABOVE;
  else if (y>YMAX)
    code|=BELOW;
  return code;
}
