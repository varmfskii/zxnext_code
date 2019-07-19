SRCS=zxnftp.c cmd_cd.c cmd_exit.c cmd_get.c cmd_id.c cmd_ls0.c cmd_ls.c cmd_mkdir.c cmd_put.c cmd_rm.c endserver.c net.c readline.c startserver.c uart.c work.c

OBJS=$(SRCS:.c=.o)

OPT=-clib=sdcc_iy -SO3 --max-allocs-per-node200000 --opt-code-size

APP=-create-app

%.o: %.c
	zcc +zxn -c $(OPT) $<

all: zxnftp.tap

zxnftp.tap: $(OBJS)
	zcc +zxn -o zxnftp $(OPT) $(APP) $^

cmd_cd.o: cmd_cd.c zxnftp.h
cmd_exit.o: cmd_exit.c zxnftp.h
cmd_get.o: cmd_get.c zxnftp.h
cmd_id.o: cmd_id.c zxnftp.h
cmd_ls0.o: cmd_ls0.c zxnftp.h
cmd_ls.o: cmd_ls.c zxnftp.h
cmd_mkdir.o: cmd_mkdir.c zxnftp.h
cmd_put.o: cmd_put.c zxnftp.h
cmd_rm.o: cmd_rm.c zxnftp.h
endserver.o: endserver.c zxnftp.h
net.o: net.c zxnftp.h
ok.o: ok.c zxnftp.h
readline.o: readline.c zxnftp.h
startserver.o: startserver.c zxnftp.h
uart.o: uart.c zxnftp.h
work.o: work.c zxnftp.h
zxnftp.o: zxnftp.c zxnftp.h

.PHONY: clean distclean

clean:
	rm -f $(OBJS) *~ zcc_opt.def
	rm -f zxnftp_CODE.bin zxnftp_UNASSIGNED.bin

distclean: clean
	rm -f zxnftp.tap
