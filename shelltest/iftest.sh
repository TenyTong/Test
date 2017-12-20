#!bin/bash
# The program dudge 

read -p "Please input y or n: " ch
[ "$ch" == "y" -o "$ch" == "Y" ] && echo "continue" && exit 0
[ "$ch" == "n" -o "$ch" == "N" ] && echo "done" && exit 0
