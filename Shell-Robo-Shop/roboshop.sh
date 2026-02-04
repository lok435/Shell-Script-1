#!/bin/bash

AMI_ID="ami-0220d79f3f480ecf5"
INSTANCE_TYPE="t3.micro"
SECURITY_GROUP_ID="sg-08c7f0d0c031b570c"
#SUBNET_ID="subnet-xxxxxxxx"
REGION="us-east-1"
for instance in $@
do 
    INSTANCE_ID=$(aws ec2 run-instances \
    --image-id $AMI_ID \
    --region $REGION \
    --instance-type $INSTANCE_TYPE \
    --security-group-ids $SECURITY_GROUP_ID \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" \ 
    --query '.Instances[0].InstanceId' \
    --output text )

    if [ "$instance" == "frontend" ]; then
       IP=$(aws ec2 describe-instances \
         --instance-ids $INSTANCE_ID \
         --query '.Instances[].InstanceId.PublicIpAdress' \
         --output text
       )
    else
        IP=$(aws ec2 describe-instances \
         --instance-ids $INSTANCE_ID \
         --query 'Reservations[].Instances[].PrivateIpAddress' \
         --output text
        )
    fi 
    echo "$instance ip: $IP"  
done        