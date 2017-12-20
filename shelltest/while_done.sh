#!bin/bash
while [ "$yn" != "yes" -a "$yn" != "YES" ]
do
	read -p "Please input yes or YES: " yn
done
	echo "You are right."
