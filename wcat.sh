#######################################################################################################
#  Autor:chenay
#  Version:1
#  Time:2015.7
#  This is a watchdog program used on Epon to watch the status of socat. It can automatically restart 
#  socat if it is down.
#  usgage:
#    ./wcat.sh
#  Make sure you change the directory first when necessary.
#######################################################################################################

#!/bin/bash
#! /bin/ash
 
IP=192.168.1.3
PORT=12345
PRO_PATH="/data/cay"
export LD_LIBRARY_PATH=/data/cay:$LD_LIBRARY_PATH
echo "$LD_LIBRARY_PATH"
PROGRAM="watch.sh"
 
while true ; do

    PRO_NOW=$( ps -eo pid,comm|grep socat|grep -v grep)
    echo "$PRO_NOW"
    if [ -z "$PRO_NOW" ]; then
       # $PRO_PATH/socat /dev/ttyS1,nonblock,raw,ixon=1,opost=0,cs8,b57600,parenb=0,cstopb=0,clocal=1,cread=1,crtscts=0,icanon=0,echo=0,iexten=0,isig=0,  tcp:$IP:$PORT
       $PRO_PATH/eecat
    fi

   # PRO_STAT=`ps aux|grep $PROGRAM |grep T|grep -v grep|wc -l`

    sleep 3
done
exit 0
