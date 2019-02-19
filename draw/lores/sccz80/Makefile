COPTS=-O3 -vn

%.o: ../src/%.c ../src/draw_lr.h
	$(CC) $(MACHINE) $(COPTS) -preserve -c $< -o $@

%.o: ../src/%.asm
	z80asm --output=$@ $^

%.asm: ../src/%.c ../src/draw_lr.h
	$(CC) $(MACHINE) $(COPTS) -S $< -o $@

all: test.tap

asm: $(ASM)

test.tap: test.o draw_lr.lib
	$(CC) $(MACHINE) -ldraw_lr -lm -create-app -otest.bin $<

draw_lr.lib: $(LIBOBJS)
	z80asm -d -xdraw_lr $^

clean:
	rm -f *~ $(LIBOBJS) $(ASM) test.o *.def *.bin

distclean: clean
	rm -f test.tap draw_lr.lib
