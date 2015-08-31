#######################################################################################################
#  Autor:chenay
#  Version:1
#  Time:2015.7
#  This is a startup script for starting VCPE.
#  usgage:
#       sudo ./initVCPE.sh v0 12345
#######################################################################################################

#!/bin/bash
if [ -z "$1" -o -z "$2" ];then
    echo "usage: sudo ./initSPM.sh virtualSerialPort tcpPort"
    echo "example: sudo ./initSPM.sh v0 12345"
    exit -1
fi

#1.start tomcat server
tserver=$(top -d 1 -n 1|grep "java" )
if [ -z "$tserver" ]; then
    cd /home/tasuser/TAS/SPM/app1/bin/
    sh startup.sh
fi

#2.check the mysql status,and start it if necessary
sql=$( service mysql status | grep '[0-9]')
if [ -z "$sql" ];then
    service mysql start
fi

#3.start socat server
lis=$(netstat -nltp | grep $2 | awk '{print $7}'|cut -d '/' -f 1)
if [ "$lis" != " " ];then
    kill -9 "$lis"
fi
    cd /home/waterspinach/programs/scripts
    sh escat.sh server $1 $2 &
#4.start socat client on epon

#5.start spm program,make sure that step 2 have establish the virture serial port successfully
while [ 1 ]
do
    if [ -e "/dev/$1" ];then
        cd /home/waterspinach/programs/gateway/spm
        ./spm -n 1 -p /dev/$1
        exit 0
    fi
    sleep 3
done





