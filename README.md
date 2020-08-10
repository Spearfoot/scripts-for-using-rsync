# Wrapper scripts for using rsync

The rsync command -- whether used standalone or installed as a module -- is a powerful tool for copying filesets between UNIX-style systems. It is very efficient in that it only copies new or changed data to the target system.

__Purpose__

I wrote these wrapper scripts for the purpose of duplicating datasets from my primary to my secondary FreeNAS server. Because FreeNAS is based on FreeBSD, these scripts are somewhat FreeBSD-centric. But rsync is a common tool on all UNIX-style systems, so it shouldn't take much effort to port the scripts to run successfully on Linux distributions.

My goal was to copy new or changed files and also to remove files on the target that had been deleted on the source. If your needs are different, particularly if you want to keep files on the target that have been deleted on the source, then you will need to remove the `--delete-during` option used in the scripts.

There are two scripts in this repository: one for use with modules (__rsync-module.sh__) and one for standalone use (__rsync-invoke.sh__).

__Slow Network Performance__

Just about every rsync user notices how slow it is at transferring data. This is usually due to using SSH as the transport protocol, with its attendant encryption. A common approach to overcoming slow transfers is to use less CPU-intensive encryption algorithms or to do away with encryption altogether. I have found that using rsync modules is faster than standalone mode, and that disabling encryption speeds up standalone transfers.

On my 10Gb network, I get transfer rates of up to 2Gb/s using __rsync-module.sh__, which is quite a bit faster than the typical standalone rate of roughly 800Mb/s.

__Windows ACL Data__

Copying Windows ACLs can be a problem on some systems, particularly FreeNAS/FreeBSD, and I have selected options to avoid problems with this issue.

On some Linux distributions, __rysnc__ may support copying Windows ACLs directly, while on others it will not. In the latter case, users have reported success using robocopy in conjunction with rsync to transfer Windows ACL data.

To determine whether your environment supports copying Windows ACLs, explore these rsync options:
- `-A --acls  preserve ACLs (implies -p)`
- `-X --xattrs preserve extended attributes`

__Options__

