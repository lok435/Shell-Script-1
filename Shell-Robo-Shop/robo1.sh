AIM_ID="ami-0220d79f3f480ecf5"
SG_ID="sg-08c7f0d0c031b570c"
HOSTEDZONE_Id="Z007932124TF6WJ9OLE5"
DOMAIN_NAME="frontend.bnbs.life"

for instance in $@
do
    INSTANCE_ID=$(aws ec2 run-instances \
  --image-id=$AMI_ID \
  --instance-type t3.micro \
  --security-group-ids=$SG_ID \
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
        RECORD_NAME="$instance.$DOMAIN_NAME"
    fi
    echo " ipadress is : $IP"


 aws route53 change-resource-record-sets\
  --hosted-zone-id $HOSTEDZONE_ID \
  --change-batch '
        {
  "Comment": "Update A record for www.example.com",
  "Changes": [
    {
      "Action": "UPSERT",
      "ResourceRecordSet": {
        "Name": "'$RECORD_NAME'",
        "Type": "A",
        "TTL": 1,
        "ResourceRecords": [
          {
            "Value": "'$IP'"
          }
        ]
      }
    }
  ]
}
  echo "recorded updated for '$instance'"   
  '
done