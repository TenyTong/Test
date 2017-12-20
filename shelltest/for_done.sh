#!bin/bash
network="10.28.49"
for sitenu in $(seq 200 254)
do
	ping -c 1 -w 1 ${network}.${sitenu} &> /dev/null && result=0 || result=1
	if [ "$result" == 0 ]; then
		echo "Server ${network}.${sitenu} is up. "
	else
		echo "Server ${network}.${sitenu} is down. "
	fi
done
