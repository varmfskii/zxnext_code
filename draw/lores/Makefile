export CC=zcc
export MACHINE=+zxn
export LIBOBJS=_hline_lr.o _line_lr.o _vline_lr.o circle_lr.o	\
	cls_lr.o disc_lr.o line_lr.o set_lr.o
export ASM=_hline_lr.asm _line_lr.asm _vline_lr.asm circle_lr.asm	\
	cls_lr.asm disc_lr.asm line_lr.asm set_lr.asm

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

