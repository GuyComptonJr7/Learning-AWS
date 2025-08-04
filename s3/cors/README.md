# Create Website 1
## Create a Bucket
```sh
aws s3 mb s3://cors-fun-gc123
```

## Change block public access
```sh
aws s3api put-public-access-block \
    --bucket cors-fun-gc123 \
    --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=false,RestrictPublicBuckets=false"
```

## Create a Bucket Policy

```sh
aws s3api put-bucket-policy --bucket cors-fun-gc123 --policy file://bucket-policy.json
```

## Turn on static website hosting
```sh
aws s3api put-bucket-website --bucket cors-fun-gc123 --website-configuration file://website.json
```

## Upload our index.html file and include a resource that would be cross-origin
```sh
aws s3 cp index.html s3://cors-fun-gc123/index.html
```

## Get the Website endpoint for s3
```sh
aws s3api get-bucket-website --bucket cors-fun-gc123
```
http://cors-fun-gc123.s3-website.us-east-1.amazonaws.com/

# Create Website 2
## Create a Bucket
```sh
aws s3 mb s3://cors-fun-gc456
```

## Change block public access
```sh
aws s3api put-public-access-block \
    --bucket cors-fun-gc456 \
    --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=false,RestrictPublicBuckets=false"
```

## Create a Bucket Policy

```sh
aws s3api put-bucket-policy --bucket cors-fun-gc456 --policy file://bucket-policy2.json
```

## Turn on static website hosting
```sh
aws s3api put-bucket-website --bucket cors-fun-gc456 --website-configuration file://website.json
```

## upload JS file
```sh
aws s3 cp hello.js s3://cors-fun-gc456/hello.js
```

## Call API
```sh
curl -X POST -H "Content-Type: application/json" https://o49lh224vd.execute-api.us-east-1.amazonaws.com/prod/hello
```

## Apply a CORS Policy
```sh
aws s3api put-bucket-cors --bucket cors-fun-gc123 --cors-configuration file://cors.json
```

## Test the website

## Clean out the buckets and delete them
```sh
aws s3 rm s3://cors-fun-gc123/index.html
aws s3 rm s3://cors-fun-gc456/hello.js
aws s3 rb s3://cors-fun-gc123
aws s3 rb s3://cors-fun-gc456
```