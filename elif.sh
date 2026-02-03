#!/bin/bash
NUMBER=$1

if [ $NUMBER -gt 20 ];then
echo "given $NUMBER greater then 20"
elif [ $NUMBER -eq 20 ]; then
echo "given $NUMBER is equal to 20"
else 
echo "given $NUMBER is lesser than 20"
fi