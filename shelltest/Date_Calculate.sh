#!bin/bash
#The program using date to calculate date

#1输入计算的日期
echo "This program will try to calculate. "
echo "How many days will you go? "
read -p "Please input your after date (YYYYMMDD ex>20170719): " date2

#2利用正则表达式测试输入内容是否正确
date_d=$(echo $date2 | grep '[0-9]\{8\}')
if [ "$date_d" == "" ]; then
	echo "You input the wrong date..."
	exit 1
fi

#3开始计算日期
declare -i date_dem=`date --date="$date2" +%s`    #离开日期秒数
declare -i date_mow=`date +%s`                    #现在日期秒数
declare -i date_total_s=$(($date_dem-$date_now))  #剩余日期秒数
declare -i date_d=$(($date_total_s/60/60/24))     #转为天数

if [ "$date_total_s" -lt "0" ]; then              #判断是否过时
	echo "You had been left: " $((-1*$date_d)) "ago"
else 
	declare -i date_h=$(($(($date_total_s-$date_d*60*60*24))/60/60))
	echo "You will left after $date_d days and $date_h hours. "
fi
