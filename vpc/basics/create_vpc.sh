#!/bin/bash -e

# Create a vpc
VPC_ID=$(aws ec2 create-vpc \
--cidr-block 172.1.0.0/16 \
--tag-specifications 'ResourceType=vpc,Tags=[{Key=Name,Value=my-vpc}]' \
--query Vpc.VpcId \
--output text)

echo "VPC_ID: ${VPC_ID}"

# Create a IGW
IGW_ID=$(aws ec2 create-internet-gateway \
--query InternetGateway.InternetGatewayId \
--output text)

echo "IGW_ID: ${IGW_ID}"

# create a subnet
SUBNET_ID=$(aws ec2 create-subnet \
--vpc-id ${VPC_ID} \
--cidr-block 172.1.1.0/20 \
--query Subnet.SubnetId \
--output text)

echo "SUBNET_ID: ${SUBNET_ID}"

# get default route table
RT_ID=$(aws ec2 describe-route-tables \
--filters "Name=vpc-id",Values="${VPC_ID}" \
--query RouteTables[0].RouteTableId \
--output text)

echo "RT_ID: ${RT_ID}"

# Attach IGW to VPC
aws ec2 attach-internet-gateway \
--internet-gateway-id ${IGW_ID} \
--vpc-id ${VPC_ID}

# Associate Route table with subnet
aws ec2 associate-route-table \
--route-table-id ${RT_ID} \
--subnet-id ${SUBNET_ID}

# Print out delete command
echo "./delete_vpc.sh ${VPC_ID} ${SUBNET_ID} ${IGW_ID}"