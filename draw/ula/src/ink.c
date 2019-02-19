#include "draw.h"

void ink(UCHAR c) {
  /* set ink color */
  ula_color=ula_color&070|(c<<3)&0300|c&07;
}
