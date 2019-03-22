provider "aws" {
   region = "${var.workreg}" 
}

module "base" {
    source = "../../main/base"
}
