#!/bin/bash
ID=$(id -u)

if [ $ID -ne 0 ]; then 
echo -e "please run this script with root user"
exit
else 
yum install nginx -y 
fi