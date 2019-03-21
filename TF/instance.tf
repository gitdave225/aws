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

resource "aws_instance" "myinstance" {
   ami           = "${lookup(var.validamis, var.workreg)}"
   instance_type = "t2.micro"

   provisioner "local-exec" {
       command = "echo ${aws_instance.myinstance.public_ip} > ipaddress.txt"
   }
}

output "instanceid" {
  value = "${aws_instance.myinstance.id}"
}
