#
# Sets up the default security groups
#

resource "aws_security_group" "BastionSG" {
    description = "Bastion Host Security Group"
    vpc_id      = "${aws_vpc.clientvpc.id}"

    ingress {
        protocol    = "tcp"
        cidr_blocks = ["${var.TargetIP}"]
        from_port   = 22
        to_port     = 22
        description = "SSH Access to Bastion Instance"
    }

    egress {
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        from_port   = 0
        to_port     = 0
        description = "Allow Access to any external resource"
    }

    tags = {
        Name = "client-BastionSG"
        Tool = "terraform"
    }
}

output "BastionSG" {
  value = "${aws_security_group.BastionSG.id}"
}
