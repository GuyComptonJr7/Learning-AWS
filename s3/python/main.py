# Import Statements
import boto3

# Constant Variables
TMP_FILE_LOCATION = "/tmp/"
FILENAME = "test_file.txt"

bucket_name = input("Please enter a bucket name: ")

s3 = boto3.client("s3")

if not bucket_name in [x["Name"] for x in s3.list_buckets()["Buckets"]]:
    s3.create_bucket(Bucket=bucket_name)

with open(TMP_FILE_LOCATION + FILENAME, "w") as f:
    f.write("Hello, World")

with open(TMP_FILE_LOCATION + FILENAME, "rb") as f:
    s3.put_object(Bucket=bucket_name, Body=f, Key=FILENAME)
