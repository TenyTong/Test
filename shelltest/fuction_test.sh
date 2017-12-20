#!bin/bash

function printl(){
	echo "Your choice is $1"
}


case $1 in
	"one")
	printl 1
	;;
	"two")
	printl 2
	;;
	"three")
	printl 3
	;;
	*)
	echo "Usage $0 {one|two|three}"
	;;
esac
