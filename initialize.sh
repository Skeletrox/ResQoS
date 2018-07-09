#Enable forwarding
sysctl -w net.ipv4.ip_forward=1
#Delete previous configuration
tc qdisc del dev eth0 root
#Create a root node
tc qdisc add dev eth0 root handle 1: htb default 11
#Create the parent class
tc class add dev eth0 parent 1: classid 1:1 htb rate 4Mbit ceil 4Mbit burst 15k
#Some children
# tc class add dev eth0 parent 1:1 classid 1:12 htb rate 100kbit ceil 3Mbit burst 15k
tc class add dev eth0 parent 1:1 classid 1:13 htb rate 100kbps ceil 4Mbit burst 15k
tc class add dev eth0 parent 1:1 classid 1:14 htb rate 4Mbit ceil 4Mbit burst 15k
#Filters. The parent class captures EVERYTHING
tc filter add dev eth0 parent 1:0 protocol ip prio 1 u32 match ip dst 0/0 match ip src 0/0 classid 1:1
