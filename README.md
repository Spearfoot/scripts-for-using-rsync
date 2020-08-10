# Wrapper scripts for using rsync
Shell scripts for using rsync

The rsync command, both standalone and when installed as a module, are useful tools for copying filesets between UNIX-style systems. It is very efficient in that it only copies new or changed data to the target system.

Copying Windows ACLs can be a problem on some systems. The rsync options presented here avoid this problem. Some Linux distributions support copying Windows ACLs directly while others do not. In the latter case, users have had success using robocopy in conjunction with rsync to transfer Windows ACL data.

To determine whether your environment supports copying Windows ACLs, explore these rsync options:
`-A --acls  preserve ACLs (implies -p)
`-X --xattrs preserve extended attributes

