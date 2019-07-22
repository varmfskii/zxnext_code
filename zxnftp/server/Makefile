SRCS=zxnftp.c cmds.c net.c senderr.c uart.c

OBJS=$(SRCS:.c=.o)

OPT=-clib=sdcc_iy -SO3 --max-allocs-per-node200000 --opt-code-size
#OPT=-clib=sdcc_iy
TAP=-create-app -subtype=tap
SNA=-create-app -subtype=sna
DOTN=-create-app -subtype=dotn

%.o: %.c
	zcc +zxn -c $(OPT) $<

all: zxnftp.tap zxnftp.sna ZXNFTP

zxnftp.tap: $(OBJS)
	zcc +zxn -o zxnftp $(OPT) $(TAP) $^

zxnftp.sna: $(OBJS)
	zcc +zxn -o zxnftp $(OPT) $(SNA) $^

ZXNFTP: $(OBJS)
	zcc +zxn -o zxnftp $(OPT) $(DOTN) $^

zxnftp.o: zxnftp.c zxnftp.h
cmds.o: cmds.c zxnftp.h
net.o: net.c zxnftp.h
senderr.o: senderr.c zxnftp.h
uart.o: uart.c zxnftp.h

.PHONY: clean distclean

clean:
	rm -f $(OBJS) *~ zcc_opt.def
	rm -f zxnftp_CODE.bin zxnftp_UNASSIGNED.bin

distclean: clean
	rm -f zxnftp.tap zxnftp.sna ZXNFTP
