#include "zxnftp.h"

command commands[]={
		    { "?", cmd_help, "? [<cmd>]" },
		    { "CD", cmd_cd, "cd <dir>" },
		    { "DIR", cmd_ls, "dir [<dir>]"  },
		    { "EXIT", cmd_exit, "exit" },
		    { "GET", cmd_get, "get <file>" },
		    { "HELP", cmd_help, "help [<cmd>]" },
		    { "LS", cmd_ls, "ls [<dir>]" },
		    { "MGET", cmd_mget, "mget <patt>" },
		    { "MPUT", cmd_mput, "mput <patt>" },
		    { "PUT", cmd_put, "put <file>" },
		    { "PWD", cmd_pwd, "pwd" },
		    { "QUIT", cmd_exit, "exit" },
		    { "MKDIR", cmd_mkdir, "mkdir <dir>" },
		    { NULL, NULL, NULL }
};

		     
