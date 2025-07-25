#!/bin/bash -e

echo "Listing Objects"

# Checking for Bucket Name
if [ -z $1 ]; then
    echo "Bucket name not provided."
    exit 1
fi

BUCKET_NAME=$1

aws s3api list-objects \
--bucket $BUCKET_NAME \
--query Contents[].Key \
--output text