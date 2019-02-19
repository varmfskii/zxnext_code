CLIB=-clib=sdcc_iy
COMPILER=-compiler sdcc
COPTS=-SO3 --max-allocs-per-node200000 --opt-code-size -vn

%.o: ../src/%.c ../src/draw_lr.h
	$(CC) $(MACHINE) $(CLIB) $(COPTS) -preserve -c $< -o $@

%.o: ../src/%.asm
	z80asm --output=$@ $^

%.asm: ../src/%.c ../src/draw_lr.h
	$(CC) $(MACHINE) $(CLIB) $(COPTS) -S $< -o $@

all: test.tap

asm: $(ASM)

test.tap: test.o draw_lr.lib
	$(CC) $(MACHINE) $(CLIB) -ldraw_lr -lm -create-app -otest.bin $<

draw_lr.lib: $(LIBOBJS)
	z80asm -d -xdraw_lr $^

clean:
	rm -f *~ $(LIBOBJS) $(ASM) test.o *.def *.bin

distclean: clean
	rm -f test.tap draw_lr.lib
