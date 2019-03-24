#
# Setup the default s3 bucket
#

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "clientbucket" {
    bucket = "${format("%s%s", "client-s3-", lookup(var.RegionMap, var.workreg))}"
    acl    = "private"
    region = "${var.workreg}"
    server_side_encryption_configuration {
        rule {
            apply_server_side_encryption_by_default {
                sse_algorithm = "AES256"
            }
        }
    }

    tags = {
        Name = "${format("%s%s%s", "Client S3 Bucket in the ", var.workreg, " region")}"
        Tool = "terraform"
    }
}

data "aws_iam_policy_document" "clients3poldoc" {
    statement {
      effect    = "Allow"
      actions   = [
        "s3:Put*",
        "s3:Get*",
        "s3:List*",
      ]
      resources = [
          "${aws_s3_bucket.clientbucket.arn}",
          "${format("%s%s", aws_s3_bucket.clientbucket.arn, "/*")}",
      ]
      principals {
          type        = "AWS"
          identifiers = ["${data.aws_caller_identity.current.account_id}"]
      }
    }

    statement {
      effect    = "Deny"
      actions   = ["s3:*",]
      resources = [
          "${aws_s3_bucket.clientbucket.arn}",
          "${format("%s%s", aws_s3_bucket.clientbucket.arn, "/*")}",
      ]
      principals {
          type        = "AWS"
          identifiers = ["*",]
      }
      condition {
          test = "Bool"
          variable = "aws:SecureTransport"

          values = ["false"]
      }
    }

    statement {
      effect    = "Allow"
      actions   = ["s3:PutObject",]
      resources = ["${format("%s%s%s%s%s%s", aws_s3_bucket.clientbucket.arn, "/", var.Env, "/AWSLogs/", data.aws_caller_identity.current.account_id, "/*")}"]
      principals {
          type        = "AWS"
          identifiers = ["${lookup(var.BPS3, var.workreg)}"]
      }
    }
}

resource "aws_s3_bucket_policy" "clientbucketpol" {
    bucket = "${aws_s3_bucket.clientbucket.id}"
    policy = "${data.aws_iam_policy_document.clients3poldoc.json}"
}

resource "aws_s3_bucket_public_access_block" "clientbucketpab" {
    bucket = "${aws_s3_bucket.clientbucket.id}"
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
}
