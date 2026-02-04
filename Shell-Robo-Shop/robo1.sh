
for instance in $@
do
    INSTANCE_ID=$(aws ec2 run-instances \
  --image-id ami-0220d79f3f480ecf5 \
  --instance-type t3.micro \
  --security-group-ids sg-08c7f0d0c031b570c \
  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" \
  --query 'Instances[0].InstanceId' \
  --output text)

    if [ "$instance" == "frontend" ]; then
        IP=$(
            aws ec2 describe-instances \
            --instance-ids $INSTANCE_ID \
            --query 'Reservations[].Instances[].PublicIpAddress' \
            --output text
        )
    else
        IP=$(
            aws ec2 describe-instances \
            --instance-ids $INSTANCE_ID \
            --query 'Reservations[].Instances[].PrivateIpAddress' \
            --output text
        )
    fi
    echo " ipadress is : $IP"
done