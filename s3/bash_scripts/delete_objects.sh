#!/bin/bash -e

# Constant Variable
JSON_FILE=/tmp/obj_list.json

echo "Deleting Objects"

# Checking for Bucket Name
if [ -z $1 ]; then
    echo "Bucket name not provided."
    exit 1
fi

BUCKET_NAME=$1

echo "$(aws s3api list-objects \
--bucket $BUCKET_NAME \
--query '{Objects: Contents[*].{Key: Key}}' \
--output json)" | jq '.Quiet = true' > $JSON_FILE

echo "$(cat $JSON_FILE)"

aws s3api delete-objects --bucket $BUCKET_NAME --delete file://$JSON_FILE

rm $JSON_FILE