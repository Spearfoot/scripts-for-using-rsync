# Wrapper scripts for using rsync

The rsync command -- whether used standalone or installed as a module -- is a powerful tool for copying filesets between UNIX-style systems. It is very efficient in that it only copies new or changed data to the target system.

__Purpose__

I wrote these wrapper scripts for the purpose of duplicating datasets from my primary FreeNAS server to my secondary FreeNAS server. My goal was to copy new or changed files and also to remove files on the target that had been deleted on the source. 

If your needs are different, particularly if you want to keep files on the target that have been deleted on the source, then you will need to remove the `--delete-during` option used in the scripts.

__Windows ACL Data__

Copying Windows ACLs can be a problem on some systems. On some operating system distribution, rysnc may support copying Windows ACLs directly, while on others it will not. In the latter case, users have reported success using robocopy in conjunction with rsync to transfer Windows ACL data.

To determine whether your environment supports copying Windows ACLs, explore these rsync options:
- `-A --acls  preserve ACLs (implies -p)`
- `-X --xattrs preserve extended attributes`

