export CC=zcc
export MACHINE=+zxn
export LIBOBJS=_hline_l2.o _line_l2.o _vline_l2.o circle_l2.o	\
	cls_l2.o disc_l2.o line_l2.o set_l2.o
export ASM=_hline_l2.asm _line_l2.asm _vline_l2.asm circle_l2.asm	\
	cls_l2.asm disc_l2.asm line_l2.asm set_l2.asm

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

