#!/bin/bash

STAGE=$1
CONFIG_FILE="${STAGE,,}_config"

# Load environment-specific config
source "./configs/${CONFIG_FILE}.env"

echo "Launching EC2 for $STAGE stage..."

INSTANCE_ID=$(aws ec2 run-instances \
  --image-id $AMI_ID \
  --instance-type $INSTANCE_TYPE \
  --key-name $KEY_NAME \
  --security-group-ids $SECURITY_GROUP \
  --subnet-id $SUBNET_ID \
  --count 1 \
  --associate-public-ip-address \
  --query 'Instances[0].InstanceId' \
  --output text)

echo "Instance ID: $INSTANCE_ID"

aws ec2 wait instance-status-ok --instance-ids $INSTANCE_ID

PUBLIC_IP=$(aws ec2 describe-instances \
  --instance-ids $INSTANCE_ID \
  --query 'Reservations[0].Instances[0].PublicIpAddress' \
  --output text)

echo "Public IP: $PUBLIC_IP"

scp -i "$PEM_FILE" deploy_app.sh ec2-user@$PUBLIC_IP:/home/ec2-user/
ssh -i "$PEM_FILE" ec2-user@$PUBLIC_IP "bash deploy_app.sh"

if curl -s --head http://$PUBLIC_IP | grep "200 OK" > /dev/null; then
  echo "App is running!"
else
  echo "App is NOT reachable"
fi

echo "Waiting 1 minute before stopping..."
sleep 60
aws ec2 stop-instances --instance-ids $INSTANCE_ID


