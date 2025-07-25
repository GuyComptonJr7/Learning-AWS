#!/bin/bash -e

echo "Generating random objects and pushing them into bucket."

# Checking for Bucket Name
if [ -z $1 ]; then
    echo "Bucket name not provided."
    exit 1
fi

BUCKET_NAME=$1

mkdir /tmp/random_files -p

GENERATED_FILE_LOCATION=/tmp/random_files

NUM_FILES=$((RANDOM % 6 + 5))

for((i=1; i<=$NUM_FILES ;i++)); do
    echo "Creating File"
    echo "Number $i" >> $GENERATED_FILE_LOCATION/file_$i.txt
    aws s3api put-object --bucket $BUCKET_NAME --key file_$i.txt --body $GENERATED_FILE_LOCATION/file_$i.txt
done

tree $GENERATED_FILE_LOCATION

echo "Objects have been pushed"