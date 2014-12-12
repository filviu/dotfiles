#!/bin/bash
# screen_ssh.sh by Chris Jones
# Modified by Ninad Pundalik
# Released under the GNU GPL v2 licence.
# Set the title of the current screen to the username and hostname being ssh'd to
#
# usage: screen_ssh.sh $PPID hostname username
#
# This is intended to be called by ssh(1) as a LocalCommand.
# For example, put this in ~/.ssh/config:
#
# Host *
# LocalCommand /path/to/screen_ssh.sh $PPID %h %r

# If it's not working and you want to know why, set DEBUG to 1 and check the
# logfile.
DEBUG=0
DEBUGLOG="$HOME/.ssh/screen_ssh.log"

set -e
set -u

dbg ()
{
if [ "$DEBUG" -gt 0 ]; then
echo "$(date) :: $*" >> $DEBUGLOG
fi
}

dbg "$0 $*"

# We only care if we are in a terminal
tty -s

# We also only care if we are in screen, which we infer by $TERM starting
# with "screen"
if [ "${TERM:0:6}" != "screen" ]; then
dbg "Not a screen session, ${TERM:0:5} != 'screen'"
exit
fi

# We must be given three arguments - our parent process, a hostname
# (which may be "%n" if we are being called by an older SSH) and a username
if [ $# != "3" ]; then
dbg "Not given enough arguments (must have PPID, hostname and username)"
exit
fi

# We don't want to do anything if BatchMode is on, since it means
# we're not an interactive shell
set +e
grep -a -i "Batchmode yes" /proc/$1/cmdline >/dev/null 2&>1
RETVAL=$?
if [ "$RETVAL" -eq "0" ]; then
dbg "SSH is being used in Batch mode, exiting because this is probably an auto-complete or similar"
exit
fi
set -e

# Use the safer %h and %r variables. %n has a buggy implementation in some versions of OpenSSH
HOST="$2"
USER="$3"

echo $USER"@"$HOST | awk '{ printf ("\033k%s\033\\", $NF) }'

dbg "Done."
