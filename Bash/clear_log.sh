#!/bin/bash

# Date June 28th, 2022

# Clean a log file

ROOT_UID=0
LINES=60
LOG_DIR=/var/log
ERRPRIV=86
ERRCD=87

# Check if the user is root

if [[ "$UID" -ne "$ROOT_UID" ]]
then echo "You are not root. Exiting"
exit $ERRPRIV
fi

# Check if the script can cd into directory

cd $LOG_DIR
if [[ `pwd` != "$LOG_DIR" ]]
then echo "Cannot change into directory; have you changed anything?"
exit $ERRCD
fi

# See if the user would like to save a different number of lines

if [[ -n "$1" ]]
then lines=$1
else lines=$LINES
fi

# Save the lines to a file and make the file a system file

tail -n $lines messages > mesg.tmp
mv mesg.tmp messages

# Clear the log file

cat /dev/null > wtmp
echo "Log cleared."

# Exit

exit 0
