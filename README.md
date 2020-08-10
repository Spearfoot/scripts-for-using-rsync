# Wrapper scripts for using rsync
## Shell scripts for using rsync

The rsync command -- whether used standalone or installed as a module -- is a useful tool for copying filesets between UNIX-style systems. It is very efficient in that it only copies new or changed data to the target system.

I wrote these wrapper scripts for the purpose of duplicating filesets between systems.

__Windows ACL Data__

Copying Windows ACLs can be a problem on some systems. The rsync options presented here avoid this problem. Some Linux distributions support copying Windows ACLs directly while others do not. In the latter case, users have had success using robocopy in conjunction with rsync to transfer Windows ACL data.

To determine whether your environment supports copying Windows ACLs, explore these rsync options:
- `-A --acls  preserve ACLs (implies -p)`
- `-X --xattrs preserve extended attributes`

