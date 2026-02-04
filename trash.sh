#!/bin/bash
STARTTIME=$(date +%s)
TIMESTAMP=$(date)
ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
set -e 
trap 'echo "Error on line $LINENO with exit status $?"' ERR

mkdir -p /var/log/Shell-script &>> LOG_FILE
LOG_FOLDER="/var/log/Shell-script"
LOG_FILE="/var/log/Shell-script/$0.log"

if [ $ID -ne 0 ];then 
echo -e " $R..please run this script with root user $N" 
fi

for package in $@
do 
    yum list installed $package &>>  $LOG_FILE
    if [ $? -ne 0 ];then 
    yum install $package -y  &>>  $LOG_FILE
    else
    echo -e "$package..is already installed $Y skipping$N"
    fi
done
echo "this script executed at $TIMESTAMP"
echo "this line is for demonstrating"
sleep 11
ENDTIME=$(date +%s)
TOTALTIME=$(($ENDTIME-$STARTTIME))
echo -e " $R..total script execution time is :$N..$G $TOTALTIME $N"