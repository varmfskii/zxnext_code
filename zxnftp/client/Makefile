sources=zxnftp.c backspace.c execute.c backspace.c finish.c		\
	commands.c init.c parse.c cmd_help.c cmd_cd.c cmd_ls.c		\
	cmd_exit.c cmd_get.c cmd_help.c cmd_mget.c cmd_mput.c		\
	cmd_put.c cmd_pwd.c cmd_mkdir.c call_simple.c sendstr.c		\
	error.c srvrerr.c sendraw.c call_put.c call_get.c cmd_rm.c

objects=$(sources:.c=.o)

all: dependencies zxnftp

dependencies: $(sources)
	./mkdeps.sh $@ $^

zxnftp: $(objects)
	$(CC) -o $@ $^ -lcurses

include dependencies

.PHONY: clean distclean

clean:
	rm -f $(objects) *~

distclean: clean
	rm -f zxnftp dependencies
