resource "aws_s3_bucket" "site1" {
  bucket = "${var.bucket_name}"
  acl    = "public-read"
  policy = "${file("policy.json")}"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}
