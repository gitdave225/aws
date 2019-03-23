resource "aws_key_pair" "mykp" {
    key_name = "mydcaws"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCc3nQ3uTpMZVIenCOOwWNmtRRLbZ2DcHPFbzUumUJCzZrJIKhkaVvkh/y0aJoGDdxQBpqOh2cw9w9aLFYwU25fVZt14xNf2ux+ZTui/x5g25SGEzQHhJE8a3N5dXrGomXnFaP0lwYe9O906MX3U19mMk9eGk1WkK3OwgKIqqDUZVRzPjrBW+n1YA/703Up3LTaKJSS5LbDHsdHzVjD5wO+6UMSR/ukd9Gxnn6p00IdQNKEhtDzMsFtjJeiIPjWY7kw6eQVOQt04NUIWodRn6Ijjdo0fJtgpdQ6V7Ktu2xtOaGSD8YPUbLDuaicoEccLOJCFtZ9Fs6j8+A/FpYTSqYT email@example.com"
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

output "bastionid" {
  value = "${aws_instance.myinstance.id}"
}
