## Create a user with no permissions
Create a new user with new access keys
```sh
aws iam create-user --user-name sts-machine-user
aws iam create-access-key --user-name sts-machine-user --output table
aws configure
nano ~/.aws/credentials
aws sts get-caller-identity --profile sts
terraform init
terraform plan
terraform apply
```

Make sure I do not have access to s3
```sh
aws s3api list-objects --bucket sts-example-bucket-gc1234 --profile sts
```
Create the assumed role session
```sh
aws sts assume-role \
    --role-arn arn:aws:iam::236292170642:role/s3AccessRole \
    --role-session-name s3-access-example \
    --profile sts
```
Enter the generated credentials into the ~/.aws/credentials file under the profile assumed. Attempt to list the objects under the assumed profile
```sh
aws s3api list-objects --bucket sts-example-bucket-gc1234 --profile assumed
```

## Clean up terraform
Tear down the infrastructure setup by terraform and delete the user's api key and the user
```sh
terraform destroy
aws iam delete-access-key --user-name sts-machine-user --access-key-id <ACCESS_KEY_ID>
aws iam delete-user --user-name sts-machine-user
```