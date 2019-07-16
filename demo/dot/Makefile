DOT=-subtype=dot -create-app

OPT=-clib=sdcc_iy -SO3 --max-allocs-per-node200000 --opt-code-size

all: ARGS HELLO

ARGS: args.c 
	zcc +zxn -o $@ $(DOT) $(OPT) $<

HELLO: hello.c 
	zcc +zxn -o $@ $(DOT) $(OPT) $<

.PHONY: clean distclean

clean:
	rm -f ARGS_CODE.bin ARGS_UNASSIGNED.bin HELLO_CODE.bin	\
	HELLO_UNASSIGNED.bin zcc_opt.def *~

distclean: clean
	rm -f ARGS HELLO

