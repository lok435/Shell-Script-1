#!/bin/bash

AMI_ID="ami-0220d79f3f480ecf5"
INSTANCE_TYPE="t3.micro"
SECURITY_GROUP_ID="sg-08c7f0d0c031b570c"
#SUBNET_ID="subnet-xxxxxxxx"
REGION="us-east-1"

aws ec2 run-instances \
  --region $REGION \
  --image-id $AMI_ID \
  --instance-type $INSTANCE_TYPE \
  --security-group-ids $SECURITY_GROUP_ID \
  #--subnet-id $SUBNET_ID \
  --tag-specifications 'ResourceType=instance,Tags={Key=<TagKey>,Value=mongo}' 