#!/bin/bash
# my socat rogram for VPE program
VSP_DIR=/dev/$2
DEV_DIR=/dev/$2
SERVER_PORT=$3
SERVER_IP=192.168.1.3
IFLAG="ixon=1"
OFLAG="opost=0"
CFLAG="cs8,b57600,parenb=0,cstopb=0,clocal=1,cread=1,crtscts=0"
LFLAG="icanon=0,echo=0,iexten=0,isig=0"
SPEEDFLAG=
#SPEEDFLAG="ispeed=4097,ospeed=4097"
IO_CTRL_FLAG=$IFLAG,$OFLAG,$CFLAG,$LFLAG,$SPEEDFLAG

case  "$1" in "server")
	 socat -d -d  tcp-l:$SERVER_PORT,reuseaddr,fork  pty,link=$VSP_DIR,raw,echo=0,nonblock,ignoreeof,$IO_CTRL_FLAG  
;;
 "client")
     echo " socat -d -d -d $DEV_DIR,nonblock,raw,$IO_CTRL_FLAG  tcp:$SERVER_IP:$SERVER_PORT "
     socat -d -d -d $DEV_DIR,nonblock,raw,$IFLAG,$OFLAG,$CFLAG,$LFLAG,$SPEEDFLAG tcp:$SERVER_IP:$SERVER_PORT 
#     socat -d -d -d /dev/ttyS1,nonblock,raw,ixon=1,opost=0,cs8,b57600,parenb=0,cstopb=0,clocal=1,cread=1,crtscts=0,icanon=0,echo=0,iexten=0,isig=0,  tcp:192.168.1.3:12345
;;
"test")
	 socat  -d -d  -,icanon=0,echo=0,raw,min=0,icrnl=0,isig  $DEV_DIR,echo=0,raw
;;
"init")
    socat stty -F $DEV_DIR speed 115200 cs8 -parenb -cstopb -echo
;;
esac

