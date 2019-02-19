#include "draw_l2.h"

#define LEFT 1
#define RIGHT 2
#define ABOVE 4
#define BELOW 8

static UCHAR outcode(short x, short y);

void line_l2(short coords[4]) {
  /* clipped line using Cohen-Sutherland algorithm */
  short x0, x1, y0, y1;
  short x, y, dy, dx;
  UCHAR code, code0, code1;

  x0=coords[0];
  y0=coords[1];
  x1=coords[2];
  y1=coords[3];
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
      coords[0]=x0;
      coords[1]=y0;
      coords[2]=x1;
      coords[3]=y1;
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
