#include "draw.h"

void paper(UCHAR c) {
  /* set paper color */
  ula_color=ula_color&07|(c<<3)&0370;
}
