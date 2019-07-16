SRCS=readconfig.c openfile.c closefile.c readline.c

OBJS=$(SRCS:.c=.o)

OPT=-clib=sdcc_iy -SO3 --max-allocs-per-node200000 --opt-code-size

APP=-create-app

%.o: %.c
	zcc +zxn -c $(OPT) $<

all: readconfig.tap

readconfig.tap: $(OBJS)
	zcc +zxn -o readconfig $(OPT) $(APP) $^

closefile.o: closefile.c myfile.h
openfile.o: openfile.c myfile.h
readconfig.o: readconfig.c myfile.h
readline.o: readline.c myfile.h

.PHONY: clean distclean

clean:
	rm -f $(OBJS) *~ zcc_opt.def
	rm -f readconfig_CODE.bin readconfig_UNASSIGNED.bin

distclean: clean
	rm -f readconfig.tap
