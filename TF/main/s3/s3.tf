# provider "aws" {
#     region = "us-east-1" 
# }

resource "aws_s3_bucket" "client-s3-ue1" {
    bucket = "client-s3-ue1"
    acl    = "private"
}
