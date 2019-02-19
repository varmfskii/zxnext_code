CLIB=-clib=sdcc_ix
COMPILER=-compiler sdcc
COPTS=-SO3 --max-allocs-per-node200000 --opt-code-size -vn

%.o: ../src/%.c ../src/draw.h
	$(CC) $(MACHINE) $(CLIB) $(COPTS) -preserve -c $< -o $@

%.o: ../src/%.asm
	z80asm --output=$@ $^

%.asm: ../src/%.c ../src/draw.h
	$(CC) $(MACHINE) $(CLIB) $(COPTS) -S $< -o $@

all: test.tap

asm: $(ASM)

test.tap: test.o draw.lib
	$(CC) $(MACHINE) $(CLIB) -ldraw -lm -create-app -otest.bin $<

draw.lib: $(LIBOBJS)
	z80asm -d -xdraw $^

clean:
	rm -f *~ $(LIBOBJS) $(ASM) test.o *.def *.bin

distclean: clean
	rm -f test.tap draw.lib
