#
# Setup the Auto Scaling Group
#

resource "aws_launch_configuration" "clientLC" {
    name_prefix          = "${format("%s%s%s", "clientLC-", lookup(var.RegionMap, var.workreg), "-")}"
    image_id             = "${lookup(var.validamis, var.workreg)}"
    instance_type        = "${var.AmzInstance}"
    iam_instance_profile = "${var.clientiprof}"
    key_name             = "${var.PubKey}"
    security_groups      = ["${aws_security_group.asgSG.id}"]
    user_data            = "${file("../../main/asgwalb/userdata.sh")}"

    lifecycle {
      create_before_destroy = true
    }
}

resource "aws_launch_template" "foobar" {
  name_prefix   = "foobar"
  image_id      = "ami-1a2b3c"
  instance_type = "t2.micro"
}
resource "aws_autoscaling_group" "clientASG" {
    name                 = "terraform-asg-example"
    launch_configuration = "${aws_launch_configuration.clientLC.name}"
    min_size             = "${var.MinFS}"
    max_size             = "${var.MaxFS}"

    lifecycle {
      create_before_destroy = true
    }

    launch_template {
      id      = "${aws_launch_template.foobar.id}"
      version = "$$Latest"
    }
}
