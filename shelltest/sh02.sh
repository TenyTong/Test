#!bin/bash
testing=$(netstat -tuln | grep ":80 ") #检测port80是否存在80:WWW
if [ "$testing" != "" ]; then
     echo "WWW is running in my system."
fi
