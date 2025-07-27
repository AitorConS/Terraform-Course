data "aws_iam_policy_document" "static_website" {
  statement {
    sid = "PublicReadGetObject"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = ["s3:GetObject"]

    resources = ["${aws_s3_bucket.public_read_bucket.arn}/*"]
  }
}


resource "aws_s3_bucket" "public_read_bucket" {
  bucket = "my_public_read_bucket"
}

output "iam_policy" {
  value = data.aws_iam_policy_document.static_website.json
}