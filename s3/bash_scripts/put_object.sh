#!/bin/bash -e

# Checking for Bucket Name
if [ -z $1 ]; then
    echo "Bucket name not provided."
    exit 1
fi

# Checking for Object Name
if [ -z $2 ]; then
    echo "Object name not provided."
    exit 1
fi

OBJECT_NAME=$2
BUCKET_NAME=$1

aws s3api put-object --bucket $BUCKET_NAME --key $OBJECT_NAME --body $OBJECT_NAME