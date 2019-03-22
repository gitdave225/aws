variable "workreg" {
    default = "us-east-1"
}

variable "validamis" {
    type = "map"
    default = {
        "us-east-1" = "ami-0de53d8956e8dcf80"
        "us-west-2" = "ami-061392db613a6357b"
    }  
}


provider "aws" {
   region = "${var.workreg}"
}

resource "aws_key_pair" "mykp" {
    key_name = "defkeypair"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
}


resource "aws_instance" "myinstance" {
   ami                = "${lookup(var.validamis, var.workreg)}"
   instance_type      = "t2.micro"
   key_name           = "${aws_key_pair.mykp.key_name}"

   provisioner "local-exec" {
       command        = "echo ${aws_instance.myinstance.private_ip} > ipaddress.txt"
   }
   
   lifecycle {
       ignore_changes = [ "key_name" ]
   }

   tags {
       Name           = "Test Instance"
       Tool           = "terraform"
   }

   volume_tags {
       Name           = "Test Instance Disks"
       Tool           = "terraform"
   }
}

output "instanceid" {
  value = "${aws_instance.myinstance.id}"
}
