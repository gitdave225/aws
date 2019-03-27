#
# Setup Security Groups for the ASG with ALB module
#

resource "aws_security_group" "asgSG" {
    description = "Auto Scaling Group Security Group"
    vpc_id      = "${var.clientvpc}"

    ingress {
        protocol        = "tcp"
        security_groups = ["${var.webSG}"]
        from_port       = 80
        to_port         = 80
        description     = "HTTP Access"
    }

    ingress {
        protocol        = "tcp"
        security_groups = ["${var.webSG}"]
        from_port       = 443
        to_port         = 443
        description     = "HTTPS Access"
    }

    ingress {
        protocol        = "tcp"
        security_groups = ["${var.BastionSG}"]
        from_port       = 22
        to_port         = 22
        description     = "Bastion Host SSH Access"
    }

    egress {
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        from_port   = 0
        to_port     = 0
        description = "Allow Access to any external resource"
    }

    tags = {
        Name = "client-asgSG"
        Tool = "terraform"
    }
}

output "asgSG" {
  value = "${aws_security_group.asgSG.id}"
}
