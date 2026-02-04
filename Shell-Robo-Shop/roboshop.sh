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
    #--subnet-id $SUBNET_ID \
    --tag-specifications 'ResourceType=instance,Tags={Key=Name,Value=$instance}' 
    --query 'Reservations[].Instances[].PublicIpAddress' \
    --output text )

    if [ $instance == frontend ];then
       IP=$(
        aws ec2 describe-instances\
         --instance-ids $INSTANCE_ID\
         --query 'Reservations[0].Instances[0].PublicIpAddress'\
         --output text
       )
    else
        IP=$(
        aws ec2 describe-instances\
         --instance-ids $INSTANCE_ID\
         --query 'Reservations[0].Instances[0].PrivateIpAddress'\
         --output text
        )
    fi   
done        