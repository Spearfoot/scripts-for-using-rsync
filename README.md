# Wrapper scripts for using rsync

The __rsync__ command -- whether used standalone or installed as a module -- is a powerful tool for copying filesets between UNIX-style systems. It is very efficient in that it only copies new or changed data to the target system.

__Purpose__

I wrote these wrapper scripts for the purpose of duplicating datasets from my primary to my secondary FreeNAS server. Because FreeNAS is based on FreeBSD, these scripts are somewhat FreeBSD-centric. But __rsync__ is a common tool on all UNIX-style systems, so it shouldn't take much effort to port the scripts to run successfully on Linux distributions.

My goal was to copy new or changed files and also to remove files on the target that had been deleted on the source. If your needs are different, particularly if you want to keep files on the target that have been deleted on the source, then you will need to remove the `--delete-during` option used in the scripts.

There are two scripts in this repository: one for use with modules (__rsync-module.sh__) and one for standalone use (__rsync-invoke.sh__).

__Slow Network Performance__

Just about every __rsync__ user notices how slow it is at transferring data. This is usually due to using SSH as the transport protocol, with its attendant encryption. A common approach to overcoming slow transfers is to use less CPU-intensive encryption algorithms or to do away with encryption altogether. I have found that using __rsync__ modules is faster than standalone mode, and that disabling encryption speeds up standalone transfers.

On my 10Gb network, I get transfer rates of up to 2Gb/s using __rsync-module.sh__, which is quite a bit faster than the typical __rsync-invoke.sh__ rate of roughly 800Mb/s.

__Windows ACL Data__

Copying Windows ACLs can be a problem on some systems, particularly FreeNAS/FreeBSD, and I have selected options to avoid problems with this issue. On FreeNAS this means avoiding these options:

- `-a, --archive Equals -rlptgoD (no -H, -A, -X)`
- `-p, --perms   Preserve permissions`
- `-A, --acls    Preserve ACLs (implies -p)`

On some Linux distributions, __rsync__ may support copying Windows ACLs directly, while on others it will not. In the latter case, users have reported success using __robocopy__ in conjunction with __rsync__ to transfer Windows ACL data.


To determine whether your environment supports copying Windows ACLs, explore the options above along with:
- `-X --xattrs preserve extended attributes`

__Options__

These are the options used in both scripts:
- `-r  recurse into directories`
- `-l  copy symlinks as symlinks`
- `-t  preserve modification times`
- `-g  preserve group`
- `-o  preserve owner`
- `-D  preserve device and special files`
- `-h  human readable progress`
- `-v  increase verbosity`
- `--delete-during   receiver deletes during the transfer`
- `--inplace         write updated data directly to destination file`
- `--log-file        specify log file`

# Example usage

I run this script early every morning to synchronize dataset from my primary FreeNAS server 'BANDIT' to my secondary server 'BOOMER'

```
#!/bin/sh

# Synchronize all tank datasets from BANDIT to BOOMER

logfile=/mnt/tank/bandit/log/bandit-to-boomer.log

datasets="archives backups devtools domains hardware media music ncs opsys photo systools web"

rm ${logfile}
for dataset in $datasets; do
    # Use rsync-invoke.sh to run rsync directly:
    # /mnt/tank/systems/scripts/rsync-invoke.sh /mnt/tank/$dataset/ root@boomer-storage:/mnt/tank/$dataset ${logfile}
    # Use rsync-module.sh to target the rsync module on the remote server:
    /mnt/tank/systems/scripts/rsync-module.sh /mnt/tank/$dataset/ root@boomer-storage/tank/$dataset ${logfile}
done
```

