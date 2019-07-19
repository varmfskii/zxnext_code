SRCS=cmdresponse.c endserver.c netclose.c netrx.c nettx.c parse.c	\
	uartresponse.c zxnftp.c readline.c startserver.c uartchar.c	\
	uartread.c uartwrite.c work.c

OBJS=$(SRCS:.c=.o)

OPT=-clib=sdcc_iy -SO3 --max-allocs-per-node200000 --opt-code-size

APP=-create-app

%.o: %.c
	zcc +zxn -c $(OPT) $<

all: zxnftp.tap

zxnftp.tap: $(OBJS)
	zcc +zxn -o zxnftp $(OPT) $(APP) $^

cmdresponse.o: cmdresponse.c zxnftp.h
endserver.o: endserver.c zxnftp.h
netclose.o: netclose.c zxnftp.h
netrx.o: netrx.c zxnftp.h
nettx.o: nettx.c zxnftp.h
parse.o: parse.c zxnftp.h
readline.o: readline.c zxnftp.h
startserver.o: startserver.c zxnftp.h
uartchar.o: uartchar.c zxnftp.h
uartread.o: uartread.c zxnftp.h
uartresponse.o: uartresponse.c zxnftp.h
uartwrite.o: uartwrite.c zxnftp.h
work.o: work.c zxnftp.h
zxnftp.o: zxnftp.c zxnftp.h

.PHONY: clean distclean

clean:
	rm -f $(OBJS) *~ zcc_opt.def
	rm -f zxnftp_CODE.bin zxnftp_UNASSIGNED.bin

distclean: clean
	rm -f zxnftp.tap
