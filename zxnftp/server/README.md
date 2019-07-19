# zxnftp - ZX Next Server

A server which allows file operations between a computer and this ZX
Spectrum Next

- Commands

-- CD <dir>                - chand directory on ZX Next
-- GT <file>     -> <data> - copy file from ZX Next to client
-- L.            -> <data> - get contents of current directory on ZX Next
-- LS <dir>      -> <data> - get contents of directory on ZX Next
-- MD <dir>                - create directory on ZX Next
-- PD            -> <data> - get current directory from ZX Next
-- PT <file>     <- <data> - copy file from client to ZX Next
-- RM <file/dir>           - delete file/directory on ZX Next
-- XX                      - kill server

configuration is in a file produced by mkzxnftpcfg.py
