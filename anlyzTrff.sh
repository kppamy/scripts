#######################################################################################################
#  Autor:chenay
#  Version:1
#  Time:2015.7
#  This script is for analyzing the network traffic . It takes the output of tcpdump as input.
#  and call an subscript calTimeDiff.sh to calculate the time difference.
#  Usage:
#      ./anlyzTrff.sh tcpdump.out
#######################################################################################################

#! /bin/bash 

#calculate the recieved bytes
rx=0
for var in $(grep -Hn  length  $1 | cut -d ',' -f 8 |cut -d ' ' -f 3)
    do
    rx=$(($rx+var+20))
done

#calculate the elapsed time
start_rx=$(grep -Hn  length  $1 | cut -d ',' -f 1|cut -d ':' -f 3-|cut -d ' ' -f 1|head -n 1)
end_rx=$(grep -Hn  length  $1 | cut -d ',' -f 1|cut -d ':' -f 3-|cut -d ' ' -f 1|tail -n 1)

diff=$(./calTimeDiff.sh $start_rx $end_rx)
#res= $(echo "scale=3; (rx*1000)/(diff)"| bc )
echo "receive $rx bytes during $start_rx and $end_rx"
echo "the traffic is  $(((rx*1000)/diff)) bps"

