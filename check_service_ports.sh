#!/bin/bash - 
#===============================================================================
#
#          FILE: check_services.sh
# 
#         USAGE: ./check_services.sh 
# 
#   DESCRIPTION:  check Service's ports 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Firxiao (), 
#  ORGANIZATION: 
#       CREATED: 08/30/16 22:04
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error


##Service Lists
services=(DNS NFS AD SQLSERVER RDP SSH)

DNS()
{
udp_ports=(53)
tcp_ports=(53)
}

NFS()
{
udp_ports=()
tcp_ports=()
}

AD()
{
tcp_ports=(389 88 53 445 464 25 135 139 636 3268 3269 5722 9389)
udp_ports=(389 88 53 445 464 636 67 123 137 138 2535)
}

SQLSERVER()
{
tcp_ports=(1434 512)
udp_ports=(1434)
}

RDP()
{
tcp_ports=(3389)
udp_ports=()
}
SSH()
{
tcp_ports=(22)
udp_ports=()
}


##ps3
export PS3=`echo -e "\033[31mPlease input Service Num: \033[0m"`

##main function
function main()
{
check_nc
select var in ${services[@]}
do
$var
#echo -e   "\033[31mPlease input ip: \033[0m"
read -p "Please input dest IP: " dest_ip
echo  "##############"
echo -e  "checking  \e[1;32m $dest_ip \e[0m \e[1;34m  $var \e[0m "
echo -e  "####################"
check_udp
check_tcp
echo -e  "####################"
break
done
}


if [ $# != 0 ]
then
echo "Useage: run `basename $0` only"
exit 1
fi


function check_nc()
{
which nc
if [ $? -ne 0 ];then
echo -e "Please install nc"
exit 1
fi
}


function check_udp()
{
#        echo -e "checking $dest_ip udp ports:"
for u in ${udp_ports[@]}; do
        #echo "nc -vz -u $dest_ip $t"
        nc -vzu -t 2 $dest_ip $u &> /dev/null
        if [ $? -ne 0 ]; then
                echo -e "\e[1;31m udp: $u is closed\e[0m"
        else
                echo -e "\e[1;32m udp: $u is opened\e[0m"
fi
done
}

function check_tcp()
{
        #echo -e "checking $dest_ip tcp ports:"
for t in ${tcp_ports[@]}; do
        #echo "nc -vz -t $dest_ip $t"
        nc -vzt -w 2 $dest_ip $t &> /dev/null
        if [ $? -ne 0 ]; then
                echo -e "\e[1;31m tcp: $t is closed\e[0m"
        else
                echo -e "\e[1;32m tcp: $t is opened\e[0m"
fi
done
}
#check_nc
#check_udp
#check_tcp

main
exit 0


