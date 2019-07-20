# zxnftp - ZX Next Server

A server which allows file operations between a computer and this ZX
Spectrum Next

- Commands

    - CD \<dir> - change directory on ZX Next

    - DR \<drive> - change drive on ZX Next

    - GT \<file> => \<data> - copy file from ZX Next to client
      (unimplemented)

    - ID => <id> - get server id
    
    - L. => \<data> - get contents of current directory on ZX Next
      (unimplemented)

    - LS \<dir> => \<data> - get contents of directory on ZX Next
      (unimplemented)

    - MD \<dir> - create directory on ZX Next (unimplemented)

    - PD => \<data> - get current directory from ZX Next
      (unimplemented)

    - PT \<file> \<= \<data> - copy file from client to ZX Next
      (unimplemented)

    - RM \<file/dir> - delete file/directory on ZX Next
      (unimplemented)

    - RR - Continue (intermediate command)

    - XX - kill server

- Responses

    - OK - No error

    - NE - File/directory does not exist

    - UK - Unrecognized command

    - XX - Unidentified error
    
configuration is in a file produced by mkzxnftpcfg.py
