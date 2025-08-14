#!/bin/bash -e

# Checking Input
if [ -z $1 ]; then
    echo "Missing VPC ID"
else
    VPC_ID=$1
fi

if [ -z $2 ]; then
    echo "Missing SUBNET ID"
else
    SUBNET_ID=$2
fi

if [ -z $3 ]; then
    echo "Missing IGW ID"
else
    IGW_ID=$3
fi

# detach IGW with subnet
aws ec2 detach-internet-gateway \
--internet-gateway-id ${IGW_ID} \
--vpc-id ${VPC_ID}

# Delete IGW
aws ec2 delete-internet-gateway --internet-gateway-id ${IGW_ID}

# Delete Subnet
aws ec2 delete-subnet --subnet-id ${SUBNET_ID}

# Delete VPC
aws ec2 delete-vpc --vpc-id ${VPC_ID}