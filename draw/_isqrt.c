#include "draw.h"

short _isqrt(short x) {
  /* integer square root routine */
  short one, res;
  
  if (x<0) return -1;
  res=0;
  one=1<<14;
  while (one>x) one>>=2;
  while (one!=0) {
    if (x>=res+one) {
      x-=(res+one);
      res+=one<<1;
    }
    res>>=1;
    one>>=2;
  }
  return res;
}
