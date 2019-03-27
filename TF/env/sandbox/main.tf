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

module "s3" {
    source = "../../main/s3"

    workreg   = "${var.workreg}"
    Env       = "${var.Env}"
    RegionMap = "${var.RegionMap}"
    BPS3      = "${var.BPS3}"
    clientvpc = "${module.base.clientvpc}"
    clientRT  = "${module.base.clientRT}"
}

module "asgwalb" {
    source = "../../main/asgwalb"

    workreg     = "${var.workreg}"
    Env         = "${var.Env}"
    RegionMap   = "${var.RegionMap}"
    validamis   = "${var.validamis}"
    PubKey      = "${var.PubKey}"
    AmzInstance = "${var.AmzInstance}"
    MinFS       = "${var.MinFS}"
    MaxFS       = "${var.MaxFS}"
    HighCPUAlrm = "${var.HighCPUAlrm}"
    LowCPUAlrm  = "${var.LowCPUAlrm}"
    clientvpc   = "${module.base.clientvpc}"
    BastionSG   = "${module.base.BastionSG}"
    webSG       = "${module.base.webSG}"
    clientFE1   = "${module.base.clientFE1}"
    clientFE2   = "${module.base.clientFE2}"
    clientiprof = "${module.base.clientiprof}"
}
