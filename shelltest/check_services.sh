#!bin/bash
#The program will use netstat and grep to check my WWW,SSH,FTP and Mail services

echo "hello I will use netstat and grep to check my linux services"
echo "Let's do it!"

#1.开始进行测试，并输出相应的测试信息
testing=$(netstat -tuln | grep ":80") #检测port80是否存在80:WWW
if [ "$testing" != "" ]; then
	echo "WWW is running in my system."
fi
testing=$(netstat -tuln | grep ":22") #检测port22是否存在22:SSH
if [ "$testing" != "" ]; then
	echo "SSH is running in my system."
fi
testing=$(netstat -tuln | grep ":21") #检测port21是否存在21:FTP
if [ "$testing" != "" ]; then
	echo "FTP is running in my system."
fi
testing=$(netstat -tuln | grep ":25") #检测port25是否存在25:Mail
if [ "$testing" != "" ]; then
	echo "Mail is running in my system."
fi
testing=$(netstat -tuln | grep ":111") #检测port111是否存在111:RPC(远程过程调用)
if [ "$testing" != "" ]; then
	echo "RPC is running in my system."
fi
testing=$(netstat -tuln | grep ":631") #检测port631是否存在631:CUPS(打印服务功能)
if [ "$testing" != "" ]; then
	echo "CUPS is running in my system."
fi
