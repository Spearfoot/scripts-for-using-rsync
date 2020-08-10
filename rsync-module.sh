#!/bin/sh

if [ $# -ne 3 ]
then
  echo "Error: not enough arguments!"
  echo "Usage is: $0 r_src r_dest r_logfile"
  exit 2
fi

R_SRC=$1
R_DEST=$2
R_LOGFILE=$3

# Options:
#   -r  recurse into directories
#   -l  copy symlinks as symlinks
#   -t  preserve modification times
#   -g  preserve group
#   -o  preserve owner
#   -D  preserve device and special files
#   -h  human readable progress
#   -v  increase verbosity

#   --delete-during   receiver deletes during the transfer
#   --inplace         write updated data directly to destination file
#   --log-file        specify log file

R_OPTIONS="-rltgoDhv --delete-during --inplace --progress --log-file="${R_LOGFILE}

# Files to exclude:
#   vmware.log    VMware virtual machine log files
#   vmware-*.log
#   @eaDir/       Synology extended attributes (?)
#   @eaDir
#   Thumbs.db     Windows system files

R_EXCLUDE="--exclude vmware.log --exclude vmware-*.log --exclude @eaDir/ --exclude @eaDir --exclude Thumbs.db"

echo "+---------------------------------------------------------------------------------" | tee -a ${R_LOGFILE}
echo "+ $(date): Copy $R_SRC to $R_DEST" | tee -a ${R_LOGFILE}
echo "+---------------------------------------------------------------------------------" | tee -a ${R_LOGFILE}
rsync ${R_OPTIONS} ${R_EXCLUDE} ${R_SRC} rsync://${R_DEST}
echo "+ $(date) Transfer completed" | tee -a ${R_LOGFILE}
exit

