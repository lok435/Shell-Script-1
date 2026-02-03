#!/bin/bash
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

today="$(date +%A)"


if [ "$today" != "Sunday" ]; then 
echo "go to school"
else
echo -e "$G..enjoy the holiday $N"
fi

ID=$(id -u)
if [ $ID -ne 1 ]; then 
echo -e "$G..your a root user $N"
else 
echo -e "$R..kindly run this script with root user $N"
fi

