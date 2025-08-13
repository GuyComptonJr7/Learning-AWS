resource "aws_s3_bucket" "sts-example" {
  bucket = "sts-example-bucket-gc1234"
}

data "aws_iam_user" "sts-bucket-user" {
  user_name = "sts-machine-user"
}

data "aws_iam_policy_document" "policy" {
  statement {
    effect    = "Allow"
    actions   = ["*"]
    resources = [
            "${resource.aws_s3_bucket.sts-example.arn}",
            "${resource.aws_s3_bucket.sts-example.arn}/*"
        ]
  }
}

resource "aws_iam_policy" "s3-access-policy" {
  name        = "s3-access-policy"
  description = "A test policy for accessing s3"
  policy      = data.aws_iam_policy_document.policy.json
}

resource "aws_iam_role_policy_attachment" "s3-attach" {
  role       = aws_iam_role.s3-access-role.name
  policy_arn = aws_iam_policy.s3-access-policy.arn
}

resource "aws_iam_role" "s3-access-role" {
  name = "s3AccessRole"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = "${data.aws_iam_user.sts-bucket-user.arn}"
        }
      }
    ]})
}