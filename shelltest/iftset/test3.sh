read -p "Please input a num: " a
if [ $a = y ] || [ $a = Y ]; then
	echo "Yes,continue"
elif [ $a = n ] || [$a = N ]; then
	echo "false"
else
	echo "nice, You great!"
fi
