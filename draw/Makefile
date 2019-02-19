all: hires_lib layer2_lib lores_lib ula_lib

hires_lib:
	make -C hires

layer2_lib:
	make -C layer2

lores_lib:
	make -C lores

ula_lib:
	make -C ula

clean:
	make -C hires clean
	make -C layer2 clean
	make -C lores clean
	make -C ula clean

distclean:
	make -C hires distclean
	make -C layer2 distclean
	make -C lores distclean
	make -C ula distclean
