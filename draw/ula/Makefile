export CC=zcc
export MACHINE=+zxn
export LIBOBJS=_hline.o _line.o _static.o _vline.o circle.o cls.o	\
	disc.o ink.o line.o paper.o set.o _set.o _setbyte.o		\
	_setcolor.o setmode.o
export ASM=_hline.asm _line.asm _static.asm _vline.asm circle.asm	\
	disc.asm ink.asm line.asm paper.asm set.asm _setcolor.asm	\
	setmode.asm


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
