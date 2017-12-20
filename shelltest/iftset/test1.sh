#!/bin/bash
# The prigram is the first if then program

read -p "Please input a character(Y/n): " yn

if [ $yn == Y ] || [ $yn == y ]; then
	echo "OK,Continue"
elif [ $yn == N ] || [ $yn == n ]; then
	echo "OK,Interrupt"
else
	echo "I don't konw your choice"
fi
