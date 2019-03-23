provider "aws" {
   region = "${var.workreg}" 
}
module "base" {
    source = "../../main/base"

    workreg   = "${var.workreg}"
    Env       = "${var.Env}"
    CIDRAZ    = "${var.CIDRAZ}"
    RegionMap = "${var.RegionMap}"
    validamis = "${var.validamis}"
    AZRegions = "${var.AZRegions}"
    SNCIDR    = "${var.SNCIDR}"
    TargetIP  = "${var.TargetIP}"
    PubKey    = "${var.PubKey}"
}
