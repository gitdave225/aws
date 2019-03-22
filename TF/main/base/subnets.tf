

# azsna = "${lookup(var.AZRegions, format("%s%s", lookup(var.RegionMap, var.workreg), "a"))}"
# snfe1 = "${lookup(var.SNCIDR, format("%s%s%s", lookup(var.RegionMap, var.workreg), "fe1", var.Env))}"
# azsnb = "${lookup(var.AZRegions, format("%s%s", lookup(var.RegionMap, var.workreg), "b"))}"
# snfe2 = "${lookup(var.SNCIDR, format("%s%s%s", lookup(var.RegionMap, var.workreg), "fe2", var.Env))}"
# azsnc = "${lookup(var.AZRegions, format("%s%s", lookup(var.RegionMap, var.workreg), "c"))}"
# snapp = "${lookup(var.SNCIDR, format("%s%s%s", lookup(var.RegionMap, var.workreg), "app", var.Env))}"
# azsnd = "${lookup(var.AZRegions, format("%s%s", lookup(var.RegionMap, var.workreg), "d"))}"
# sndb = "${lookup(var.SNCIDR, format("%s%s%s", lookup(var.RegionMap, var.workreg), "db", var.Env))}"
