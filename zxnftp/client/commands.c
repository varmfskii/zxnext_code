#include "zxnftp.h"

command commands[]={
		    { "?", cmd_help, "? [<cmd>]" },
		    { "cd", cmd_cd, "cd <dir>" },
		    { "dir", cmd_ls, "dir [<dir>]"  },
		    { "exit", cmd_exit, "exit" },
		    { "get", cmd_get, "get <file>" },
		    { "help", cmd_help, "help [<cmd>]" },
		    { "ls", cmd_ls, "ls [<dir>]" },
		    { "mget", cmd_mget, "mget <patt>" },
		    { "mkdir", cmd_mkdir, "mkdir <dir>" },
		    { "mput", cmd_mput, "mput <patt>" },
		    { "put", cmd_put, "put <file>" },
		    { "pwd", cmd_pwd, "pwd" },
		    { "quit", cmd_quit, "quit" },
		    { "rm", cmd_rm, "rm <file>" },
		    { "rmdir", cmd_rmdir, "rmdir <dir>" },
		    { NULL, NULL, NULL }
};

		     
