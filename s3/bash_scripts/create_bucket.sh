#!/bin/bash -e

echo "Creating Bucket"

# Checking for Bucket Name
if [ -z $1 ]; then
    echo "Bucket name not provided."
    exit 1
fi

BUCKET_NAME=$1

aws s3api create-bucket \
--bucket $BUCKET_NAME \
--region us-east-1 \
--query Location \
--output text