resource "aws_instance" "bastioninst" {
   ami                    = "${lookup(var.validamis, var.workreg)}"
   instance_type          = "t2.micro"
   key_name               = "${var.PubKey}"
   vpc_security_group_ids = [ "${aws_security_group.BastionSG.id}" ]
   subnet_id              = "${aws_subnet.clientFE2.id}"
   iam_instance_profile   = "${aws_iam_instance_profile.clientiprof.name}"

   ebs_block_device = {
       volume_type = "gp2"
       volume_size = 20
       device_name = "/dev/xvda"
   }
   
   provisioner "local-exec" {
       command        = "echo ${aws_instance.bastioninst.private_ip} > ipaddress.txt"
   }
   
   lifecycle {
       ignore_changes = [ "key_name" ]
   }

   tags {
       Name           = "Bastion Host"
       Tool           = "terraform"
   }

   volume_tags {
       Name           = "Bastion Host Disks"
       Tool           = "terraform"
   }
}

output "bastionid" {
  value = "${aws_instance.bastioninst.id}"
}

output "bastion-pubIP" {
  value = "${aws_instance.bastioninst.public_ip}"
}

output "bastion-pubName" {
  value = "${aws_instance.bastioninst.public_dns}"
}
