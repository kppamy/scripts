#######################################################################################################
#  Autor:chenay
#  Version:1
#  Time:2015.7
#  This is a watchdog program used on Epon to watch the status of socat. It can automatically restart 
#  socat if it is down.
#  usgage:./watchcat.sh
#######################################################################################################



#!/bin/bash
#! /bin/ash
 
IP=192.168.1.3
PORT=12345
export LD_LIBRARY_PATH=/data/cay:$LD_LIBRARY_PATH
echo "$LD_LIBRARY_PATH"
PRO_PATH="/data/cay/"
PROGRAM="watch.sh"
 
while true ; do

    PRO_NOW=`ps aux | grep $PROGRAM | grep -v grep | wc -l`

    if [$PRO_NOW -lt 1]; then
    /data/cay/socat -d  /dev/ttyUSB0,nonblock,raw,ixon=1,opost=0,cs8,b57600,parenb=0,cstopb=0,clocal=1,cread=1,crtscts=0,icanon=0,echo=0,iexten=0,isig=0,  tcp:$IP:$PORT
    fi

    PRO_STAT=`ps aux|grep $PROGRAM |grep T|grep -v grep|wc -l`

    if [ $PRO_STAT -gt 0  ] ; then
        killall -9 $PROGRAM
        sleep 2
        $PRO_PATH/$PROGRAM 2>/dev/null 1>&2 &
    fi
    sleep 2
done
exit 0
