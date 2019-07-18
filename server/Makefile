SRCS=closefile.c endserver.c netclose.c netrx.c nettx.c openfile.c	\
	uartresponse.c readconfig.c readline.c startserver.c		\
	uartchar.c uartread.c uartwrite.c work.c

OBJS=$(SRCS:.c=.o)

OPT=-clib=sdcc_iy -SO3 --max-allocs-per-node200000 --opt-code-size

APP=-create-app

%.o: %.c
	zcc +zxn -c $(OPT) $<

all: readconfig.tap

readconfig.tap: $(OBJS)
	zcc +zxn -o readconfig $(OPT) $(APP) $^

closefile.o: closefile.c readconfig.h
endserver.o: endserver.c readconfig.h
netclose.o: netclose.c readconfig.h
netrx.o: netrx.c readconfig.h
nettx.o: nettx.c readconfig.h
openfile.o: openfile.c readconfig.h
readconfig.o: readconfig.c readconfig.h
readline.o: readline.c readconfig.h
startserver.o: startserver.c readconfig.h
uartresponse.o: printresponse.c readconfig.h
uartchar.o: uartchar.c readconfig.h
uartread.o: uartread.c readconfig.h
uartwrite.o: uartwrite.c readconfig.h
work.o: work.c readconfig.h

.PHONY: clean distclean

clean:
	rm -f $(OBJS) *~ zcc_opt.def
	rm -f readconfig_CODE.bin readconfig_UNASSIGNED.bin

distclean: clean
	rm -f readconfig.tap
