#######################################################################################################
#  Autor:chenay
#  Version:1
#  Time:2015.7
#  This calculate the time difference between two date which in the form of  string "hh:mm:ss.ms"
#  usgage:./calTimeDiff.sh h1:m1:s1.ms1  h2:m2:s2.ms2
#######################################################################################################

#! /bin/bash 
#echo "usage example: get_msec 10:33:56.104"
h=0
m=0
s=0
ms=0
get_msec()
{
    read -r h m s ms <<< $(echo "$1" | tr '.:' ' ')
    echo $(((10#$h*60*60*1000)+(10#$m*60*1000)+(10#$s*1000)+(10#$ms/1000)))
}
ss=$1
ee=$2
stat=$(get_msec $ss)
end=$(get_msec $ee)
diff=$(($end - $stat))
echo "$diff"
