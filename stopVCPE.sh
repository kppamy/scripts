#######################################################################################################
#  Autor:chenay
#  Version:1
#  Time:2015.7
#  This is a  script for stoping VCPE.
#  usgage:
#       sudo ./stopVCPE.sh
#######################################################################################################
#!/bin/bash

#stop the tomcat server
cd /home/tasuser/TAS/SPM/app1/bin
sh shutdown.sh

#stop the mysqld 
service  mysql stop

#stop the socat-server
soc=$( ps -eo pid,comm|awk '/socat/{print $1}')
if [  "$soc" != " " ];then
    kill -9 $soc
fi

#stop the spm
for var in  $( ps -eo pid,comm|awk '/spm/{print $1}')
do 
    kill -9 $var
done



