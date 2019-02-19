unsigned char vector[512];

void b_line(short dx, unsigned char dy) {
  short x2=-dx+dx;
  short y2=dy+dy;
  short delta=y2-dx;
  short x;
  unsigned char y;
  
  y=vector[0]=0;
  for(x=1; x<dx; x++) {
    vector[x]=y;
    delta+=y2;
    if (delta>0) {
      y++;
      delta+=x2;
    }
  }
  vector[dx]=dy;
}
