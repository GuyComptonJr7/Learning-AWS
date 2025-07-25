#!/bin/bash -e

echo "Deleting CloudFormation stack"

aws cloudformation delete-stack --stack-name example-stack-s3-gc1