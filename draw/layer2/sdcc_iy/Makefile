CLIB=-clib=sdcc_iy
COMPILER=-compiler sdcc
COPTS=-SO3 --max-allocs-per-node200000 --opt-code-size -vn

%.o: ../src/%.c ../src/draw_l2.h
	$(CC) $(MACHINE) $(CLIB) $(COPTS) -preserve -c $< -o $@

%.o: ../src/%.asm
	z80asm --output=$@ $^

%.asm: ../src/%.c ../src/draw_l2.h
	$(CC) $(MACHINE) $(CLIB) $(COPTS) -S $< -o $@

all: test.tap

asm: $(ASM)

test.tap: test.o draw_l2.lib
	$(CC) $(MACHINE) $(CLIB) -ldraw_l2 -lm -create-app -otest.bin $<

draw_l2.lib: $(LIBOBJS)
	z80asm -d -xdraw_l2 $^

clean:
	rm -f *~ $(LIBOBJS) $(ASM) test.o *.def *.bin

distclean: clean
	rm -f test.tap draw_l2.lib
