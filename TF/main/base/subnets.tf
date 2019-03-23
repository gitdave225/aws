#
# Sets up the AZs and subnets
#
resource "aws_subnet" "clientFE1" {
    availability_zone       = "${lookup(var.AZRegions, format("%s%s", lookup(var.RegionMap, var.workreg), "a"))}"
    cidr_block              = "${lookup(var.SNCIDR, format("%s%s%s", lookup(var.RegionMap, var.workreg), "fe1", var.Env))}"
    map_public_ip_on_launch = true
    vpc_id                  = "${aws_vpc.clientvpc.id}"

    tags = {
        Name = "client-External1"
        Tool = "terraform"
    }
}

resource "aws_subnet" "clientFE2" {
    availability_zone       = "${lookup(var.AZRegions, format("%s%s", lookup(var.RegionMap, var.workreg), "b"))}"
    cidr_block              = "${lookup(var.SNCIDR, format("%s%s%s", lookup(var.RegionMap, var.workreg), "fe2", var.Env))}"
    map_public_ip_on_launch = true
    vpc_id                  = "${aws_vpc.clientvpc.id}"

    tags = {
        Name = "client-External2"
        Tool = "terraform"
    }
}

resource "aws_subnet" "clientApp" {
    availability_zone       = "${lookup(var.AZRegions, format("%s%s", lookup(var.RegionMap, var.workreg), "c"))}"
    cidr_block              = "${lookup(var.SNCIDR, format("%s%s%s", lookup(var.RegionMap, var.workreg), "app", var.Env))}"
    vpc_id                  = "${aws_vpc.clientvpc.id}"

    tags = {
        Name = "client-App"
        Tool = "terraform"
    }
}

resource "aws_subnet" "clientDB" {
    availability_zone       = "${lookup(var.AZRegions, format("%s%s", lookup(var.RegionMap, var.workreg), "d"))}"
    cidr_block              = "${lookup(var.SNCIDR, format("%s%s%s", lookup(var.RegionMap, var.workreg), "db", var.Env))}"
    vpc_id                  = "${aws_vpc.clientvpc.id}"

    tags = {
        Name = "client-DB"
        Tool = "terraform"
    }
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = "${aws_eip.clienteip.id}"
  subnet_id     = "${aws_subnet.clientFE1.id}"

  tags = {
    Name = "NAT Gateway for private subnets"
    Tool = "terraform"
  }
}

resource "aws_route_table" "clientRTExternal" {
    vpc_id = "${aws_vpc.clientvpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.clientigw.id}"
    }

    tags = {
        Name = "client-RouteTablePublic"
        Tool = "terraform"
    }
}

resource "aws_route_table" "clientRT" {
    vpc_id = "${aws_vpc.clientvpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.natgw.id}"
    }

    tags = {
        Name = "client-RouteTablePrivate"
        Tool = "terraform"
    }
}

resource "aws_route_table_association" "clientExt1Assoc" {
    subnet_id = "${aws_subnet.clientFE1.id}"
    route_table_id = "${aws_route_table.clientRTExternal.id}"
}

resource "aws_route_table_association" "clientExt2Assoc" {
    subnet_id = "${aws_subnet.clientFE2.id}"
    route_table_id = "${aws_route_table.clientRTExternal.id}"
}

resource "aws_route_table_association" "clientAppAssoc" {
    subnet_id = "${aws_subnet.clientApp.id}"
    route_table_id = "${aws_route_table.clientRT.id}"
}

resource "aws_route_table_association" "clientDBAssoc" {
    subnet_id = "${aws_subnet.clientDB.id}"
    route_table_id = "${aws_route_table.clientRT.id}"
}

output "clientFE1" {
  value = "${aws_subnet.clientFE1.id}"
}

output "clientFE2" {
  value = "${aws_subnet.clientFE2.id}"
}

output "clientApp" {
  value = "${aws_subnet.clientApp.id}"
}

output "clientDB" {
  value = "${aws_subnet.clientDB.id}"
}
