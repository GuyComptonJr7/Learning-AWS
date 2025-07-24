module "s3-bucket" {
    source = "./module"
    bucket_name = "my-terraform-bucket-gc1"
    aws_region = "us-east-1"
    file_contents = "Hello World!"
    file_name = "hello_world.txt"
}