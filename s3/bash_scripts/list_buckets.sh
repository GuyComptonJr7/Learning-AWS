#!/bin/bash -e

echo "== List newest buckets"

aws s3api list-buckets | jq -r '.Buckets | sort_by(.CreationDate) | reverse | .[0:5] | .[] | .Name'

echo "..."