#!bin/bash
#The program will add 1 to the number you input

read -p "Please input a number to count for 1+2+..+number: " number
s=0
for ((i=1;i<=$number;i++))
do
	s=$(($s+$i))
done

echo "The result is : $s"

