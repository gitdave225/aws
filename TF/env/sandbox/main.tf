provider "aws" {
   region = "${var.workreg}" 
}
module "base" {
    source = "../../main/base"
    workreg = "${var.workreg}"
    Env = "${var.Env}"
    CIRDAZ = "${var.CIDRAZ}"
    RegionMap = "${var.RegionMap}"
}
