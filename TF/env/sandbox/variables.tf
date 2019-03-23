variable "workreg" {}

variable "Env" {}
# prod, nonprod, sandbox

variable "TargetIP" {}

variable "RegionMap" {
    type = "map"
    default = {
        "us-east-1" = "ue1"
        "us-west-2" = "uw2"
    }
}

variable "AZRegions" {
    type = "map"
    description = "AZs per Region"
    default = {
        "ue1a" = "us-east-1a"
        "ue1b" = "us-east-1b"
        "ue1c" = "us-east-1c"
        "ue1d" = "us-east-1d"
        "uw2a" = "us-west-2a"
        "uw2b" = "us-west-2b"
        "uw2c" = "us-west-2c"
        "uw2d" = "us-west-2d"
    }
}

variable "CIDRAZ" {
    type = "map"
    description = "CIDR assigned per AZ"
    default = {
        "ue1prod"    = "10.30.0.0/18"
        "ue1nonprod" = "10.30.64.0/18"
        "ue1sandbox" = "10.30.128.0/18"
        "uw2prod"    = "172.30.0.0/18"
        "uw2nonprod" = "172.30.64.0/18"
        "uw2sandbox" = "172.30.128.0/18"
    }  
}

variable "SNCIDR" {
    type = "map"
    description = "CIDR for Subnet"
    default = {
        "ue1fe1prod"    = "10.30.0.0/22"
        "ue1fe1nonprod" = "10.30.64.0/22"
        "ue1fe1sandbox" = "10.30.128.0/22"
        "ue1fe2prod"    = "10.30.4.0/22"
        "ue1fe2nonprod" = "10.30.68.0/22"
        "ue1fe2sandbox" = "10.30.132.0/22"
        "ue1appprod"    = "10.30.8.0/22"
        "ue1appnonprod" = "10.30.72.0/22"
        "ue1appsandbox" = "10.30.136.0/22"
        "ue1dbprod"    = "10.30.12.0/22"
        "ue1dbnonprod" = "10.30.76.0/22"
        "ue1dbsandbox" = "10.30.140.0/22"
        "uw2fe1prod"    = "172.30.0.0/22"
        "uw2fe1nonprod" = "172.30.64.0/22"
        "uw2fe1sandbox" = "172.30.128.0/22"
        "uw2fe2prod"    = "172.30.4.0/22"
        "uw2fe2nonprod" = "172.30.68.0/22"
        "uw2fe2sandbox" = "172.30.132.0/22"
        "uw2appprod"    = "172.30.8.0/22"
        "uw2appnonprod" = "172.30.72.0/22"
        "uw2appsandbox" = "172.30.136.0/22"
        "uw2dbprod"    = "172.30.12.0/22"
        "uw2dbnonprod" = "172.30.76.0/22"
        "uw2dbsandbox" = "172.30.140.0/22"
    }
}

variable "validamis" {
    type = "map"
    description = "Approved AMIs"
    default = {
        "us-east-1" = "ami-0de53d8956e8dcf80"
        "us-west-2" = "ami-061392db613a6357b"
    }  
}
