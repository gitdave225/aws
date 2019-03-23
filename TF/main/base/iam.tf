#
# Sets up the default IAM instance profile
#

data "aws_iam_policy_document" "defpoldoc" {
    statement {
      effect  = "Allow"
      principals {
        type        = "Service"
        identifiers = ["ec2.amazonaws.com"]
      }
      actions = ["sts:AssumeRole"]
    }

    statement {
      effect    = "Allow"
      actions   = [
        "ec2:describe*",
        "ec2:createtags*",
        "ec2:DescribeInstanceStatus",
      ]
      resources = ["*"]
    }

    statement {
      effect    = "Allow"
      actions   = [
        "s3:list*",
        "s3:get*",
      ]
      resources = ["*"] 
    }

    statement {
      effect    = "Allow"
      actions   = [
        "cloudwatch:get*",
        "cloudwatch:describe*",
        "cloudwatch:list*",
      ]
      resources = ["*"]
    }
}

resource "aws_iam_role" "clientrole" {
    name                = "${format("%s-%s-%s", lookup(var.RegionMap, var.workreg), var.Env, "client-role")}"
    path                = "/"
    assume_role_policy  = "${data.aws_iam_policy_document.defpoldoc.json}"  
}

resource "aws_iam_instance_profile" "clientiprof" {
    name = "${format("%s-%s-%s", lookup(var.RegionMap, var.workreg), var.Env, "client-instance-profile")}"
    role = "${aws_iam_role.clientrole.name}"
}

output "clientiprod" {
  value = "${aws_iam_instance_profile.clientiprof.name}"
}
