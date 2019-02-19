export CC=zcc
export MACHINE=+zxn
export LIBOBJS=circle_h.o cls_h.o disc_h.o set_h.o setmode_h.o _set.o	\
	_setbyte.o _hline_h.o _vline_h.o _line_h.o line_h.o
export ASM=circle_h.asm disc_h.asm setmode_h.asm _hline_h.asm	\
	_vline_h.asm _line_h.asm line_h.asm


all: ixlib iylib scclib

ixlib:
	make -C sdcc_ix

iylib:
	make -C sdcc_iy

scclib:
	make -C sccz80

clean:
	make -C sdcc_ix clean
	make -C sdcc_iy clean
	make -f sccz80 clean

distclean:
	make -C sdcc_ix distclean
	make -C sdcc_iy distclean
	make -C sccz80 distclean

