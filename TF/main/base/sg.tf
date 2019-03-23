#
# Sets up the default security groups
#

resource "aws_security_group" "BastionSG" {
    description = "Bastion Host Security Group"
    vpc_id      = "${aws_vpc.clientvpc.id}"

    ingress {
    }

    egress {
    }
    tags = {
        Name = "client-BastionSG"
        Tool = "terraform"
    }
}
