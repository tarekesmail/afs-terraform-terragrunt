include {
  path = find_in_parent_folders()
}


terraform {
  source = local.base_source
}

locals {
  base_source = "${dirname(find_in_parent_folders())}/..//modules/kms"
}

inputs = {
  alias_name              = "alias/kms-afs-backup"
  deletion_window_in_days = 30
}
