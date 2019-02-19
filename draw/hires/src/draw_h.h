/* range */
#define XMAX2 511
#define XMIN 0
#define YMAX 191
#define YMIN 0
/* drawing modes */
#define UNSET 1
#define XSET 3
#define SET 2
/* base addresses */
#define B_PIXEL 0x4000
#define B_COLOR 0x5800
#define B_ALTP 0x6000
#define B_ALTC 0x7800
/* ports */
__sfr __at 0xFE P_ULA;
__sfr __at 0xFF P_TIMEXULA;
#define HIRES 6
#define SM_MASK 7
__sfr __at 0xF5 P_T_REGSEL;
__sfr __at 0xF6 P_T_REGIO;
__sfr __banked __at 0xBF3B P_P_REGSEL;
__sfr __banked __at 0xFF3B P_P_REGIO;
__sfr __banked __at 0x123B P_N_LAYER2;
__sfr __banked __at 0x243B P_N_REGSEL;
__sfr __banked __at 0x253B P_N_REGIO;

typedef unsigned char UCHAR;

/* permit us to modify the bytes in an address */
typedef union address {
  UCHAR *a;
  struct hl {
    UCHAR l, h;
  } hl;
} address;

void _hline_h(short x0, short x1, UCHAR y, UCHAR c);
void _line_h(short x0, UCHAR y0, short x1, UCHAR y1, UCHAR c);
void _set(UCHAR *a, UCHAR f, UCHAR m);
void _setbyte(UCHAR *a, UCHAR f);
void _vline_h(short x, UCHAR y0, UCHAR y1, UCHAR c);
void circle_h(short xc, UCHAR yc, UCHAR r, UCHAR c);
void cls_h(void);
void disc_h(short xc, UCHAR yc, UCHAR r, UCHAR c);
void line_h(short x0, short y0, short x1, short y1, UCHAR c);
void set_h(short x, UCHAR y, UCHAR c);
void setmode_h(void);
