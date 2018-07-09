#!/bin/bash

create_connection() {
	echo "Connection Created" >> logs.txt

#	if [ $1 = "/dunkirk.mp4" ]
#	then
#		echo "A movie about the evacuation of 300,000 Allied Troops from the town of Dunkirk in northern France" >> logs.txt
#		echo "tc filter add dev eth0 parent 1:1 protocol ip prio 1 u32 match ip dst $2 match ip dport $3 0xffff classid 1:16" >> logs.txt
#		sudo tc filter add dev eth0 parent 1:1 protocol ip prio 1 u32 match ip dst $2 match ip dport $3 0xffff classid 1:13
		
#	elif [ $1 = "/guardians.mp4" ]
#	then
#		echo "Peter Quill finds the answer to a question, but will he like it?" >> logs.txt
#		echo "tc filter add dev eth0 parent 1:1 protocol ip prio 1 u32 match ip dst $2 match ip dport $3 0xffff classid 1:16" >> logs.txt
#		sudo tc filter add dev eth0 parent 1:1 protocol ip prio 1 u32 match ip dst $2 match ip dport $3 0xffff classid 1:13

#	elif [ $1 = "/ryan.mp4" ]
#	then
#		echo "The story of a brave platoon sent to Omaha beach during D-Day risking it all to save a single private" >> logs.txt
#		echo "tc filter add dev eth0 parent 1:1 protocol ip prio 1 u32 match ip dst $2 match ip dport $3 0xffff classid 1:16" >> logs.txt
#		sudo tc filter add dev eth0 parent 1:1 protocol ip prio 1 u32 match ip dst $2 match ip dport $3 0xffff classid 1:13

	if [ $1 = "/madmax.mp4" ]
	then
		echo "Post-Apocalyptic Australia with breathtaking cinematography and amazing directing" >> logs.txt
		echo "tc filter add dev eth0 parent 1:1 protocol ip prio 1 u32 match ip dst $2 match ip dport $3 0xffff classid 1:14" >> logs.txt
		sudo tc filter add dev eth0 parent 1:1 protocol ip prio 1 u32 match ip dst $2 match ip dport $3 0xffff classid 1:14
	else
		echo "Normal video" >> logs.txt
		echo "tc filter add dev eth0 parent 1:1 protocol ip prio 1 u32 match ip dst $2 match ip dport $3 0xffff classid 1:13" >> logs.txt
		sudo tc filter add dev eth0 parent 1:1 protocol ip prio 1 u32 match ip dst $2 match ip dport $3 0xffff classid 1:13
	fi
	

}

destroy_connection() {
	echo "Connection Destroyed" >> logs.txt
}


d=$(date)
echo "$d" >> logs.txt
echo "------------------------------------" >> logs.txt
me=$(sudo whoami)
echo "$me" >> logs.txt
if [ $6 = "connect" ]
then
	echo "$1:$2 connecting to $3:$4 via $5" >> logs.txt
	create_connection $5 $1 $2
elif [ $6 = "disconnect" ]
then
	echo "$1:$2 disconnecting from $3:$4 after accessing $5" >> logs.txt
	destroy_connection $5
else
	echo "$1:$2 interacting with $3:$4 in route $5 as $6" >> logs.txt
fi
