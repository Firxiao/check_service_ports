## A tool to scan service  ports
now suppot dns and a little service

you can custom this script add the service ports you want to check


just add new service in _services_ and add a _services_ function define the udp and tcp ports


## Usage:
```
git clone https://github.com/Firxiao/check_service_ports
cd check_service_ports
chmod +x check_service_ports.sh
./check_service_ports.sh
1) DNS        3) AD         5) RDP
2) NFS        4) SQLSERVER  6) SSH
Please input Service Num: 1
Please input dest IP: 192.168.1.1
##############
checking   192.168.1.1    DNS
####################
 udp: 53 is closed
 tcp: 53 is closed
####################
```

