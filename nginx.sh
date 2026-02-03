#!/bin/bash
STARTTIME=$(date +%s)
mkdir -p /tmp/backup
LOGFILE=$/tmp/backup
ID=$(id -u)
R="\e[33m"
G="\e[32m"
Y="\e[31m"
N="\e[0m"

validate(){
    if [ $1 -ne 0 ];then 
    echo -e "$2..$R failed $N"
    else 
    echo -e "$2..$G success $N"
    fi
}

if [ $ID -ne 0 ];then 
echo -e " $R..please run this script with root user$N"
else
echo "$G..your r a root user$N"
exit 1
fi

echo -e " $G..installing nginx$N "
yum install nginx -y 

if [ $? -ne 0 ];then 
yum install nginx -y 
validate $? "installing nginx"
else
echo -e "nginx is already installed $Y skipping$N"
fi
sleep 30
ENDTIME=$(date +%s)
TOTALTIME=$(($ENDTIME-$STARTTIME))
echo -e "total script execution time is $TOTALTIME"
