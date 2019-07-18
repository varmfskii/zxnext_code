SRCS=cmdresponse.c endserver.c netclose.c netrx.c nettx.c		\
	uartresponse.c server.c readline.c startserver.c uartchar.c	\
	uartread.c uartwrite.c work.c

OBJS=$(SRCS:.c=.o)

OPT=-clib=sdcc_iy -SO3 --max-allocs-per-node200000 --opt-code-size

APP=-create-app

%.o: %.c
	zcc +zxn -c $(OPT) $<

all: server.tap

server.tap: $(OBJS)
	zcc +zxn -o server $(OPT) $(APP) $^

cmdresponse.o: cmdresponse.c server.h
endserver.o: endserver.c server.h
netclose.o: netclose.c server.h
netrx.o: netrx.c server.h
nettx.o: nettx.c server.h
readline.o: readline.c server.h
server.o: server.c server.h
startserver.o: startserver.c server.h
uartchar.o: uartchar.c server.h
uartread.o: uartread.c server.h
uartresponse.o: uartresponse.c server.h
uartwrite.o: uartwrite.c server.h
work.o: work.c server.h

.PHONY: clean distclean

clean:
	rm -f $(OBJS) *~ zcc_opt.def
	rm -f server_CODE.bin server_UNASSIGNED.bin

distclean: clean
	rm -f server.tap
