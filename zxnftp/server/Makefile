SRCS=zxnftp.c uart.c net.c

OBJS=$(SRCS:.c=.o)

#OPT=-clib=sdcc_iy -SO3 --max-allocs-per-node200000 --opt-code-size
OPT=-clib=sdcc_iy -DDEBUG
APP=-create-app -subtype=tap

%.o: %.c
	zcc +zxn -c $(OPT) $<

all: zxnftp.tap

zxnftp.tap: $(OBJS)
	zcc +zxn -o zxnftp $(OPT) $(APP) $^

zxnftp.o: zxnftp.c zxnftp.h
net.o: net.c zxnftp.h
uart.o: uart.c zxnftp.h

.PHONY: clean distclean

clean:
	rm -f $(OBJS) *~ zcc_opt.def
	rm -f zxnftp_CODE.bin zxnftp_UNASSIGNED.bin

distclean: clean
	rm -f zxnftp.tap
