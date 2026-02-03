#!/bin/bash
STARTTIME=$(date +%s)
echo "this script is started at: $STARTTIME"
sleep 10
ENDTIME=$(date +%s)

TOTALTIME=$(($ENDTIME-$STARTTIME))

echo "the script total time is: $TOTALTIME"