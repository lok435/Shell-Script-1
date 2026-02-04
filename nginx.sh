#!/bin/bash
STARTTIME=$(date +%s)
TIMESTAMP=$(date)
ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOG_FOLDER="/var/log/Shell-script"
LOG_FILE="/var/log/Shell-script/$0.log"

mkdir -p /var/log/Shell-script &>> LOG_FILE

validate(){
    if [ $1 -ne 0 ];then 
    echo -e "$2..$R failed $N"
    else 
    echo -e "$2..$G success $N"
    fi
}

if [ $ID -ne 0 ];then 
echo -e " $R..please run this script with root user $N"
exit 1
fi

for package in $@
do 
    yum list installed $package &>> $LOG_FILE
    if [ $? -ne 0 ];then 
    yum install $package -y  &>> $LOG_FILE
    validate $? "installing nginx"
    else
    echo -e "$package..is already installed $Y skipping$N"
    fi
done
echo "this script executed at $TIMESTAMP"
set -e
echo "this line is for demonstrating"
sleep 11
ENDTIME=$(date +%s)
TOTALTIME=$(($ENDTIME-$STARTTIME))
echo -e "total script execution time is $TOTALTIME"