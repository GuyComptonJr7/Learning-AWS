#!/bin/bash -e

echo "Deploying S3 bucket via CloudFormation"

aws cloudformation deploy --template-file template.yaml --stack-name example-stack-s3-gc1 --region us-east-1 --no-execute-changeset