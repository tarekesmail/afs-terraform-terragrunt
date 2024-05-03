include {
  path = find_in_parent_folders()
}

terraform {
  source = local.base_source
}

locals {
  base_source = "${dirname(find_in_parent_folders())}/..//modules/aws-backup"
}

dependency "backups_kms" {
  config_path = "../kms/backups"
}

inputs = {
  vault_name        = "afs-backup-vault"
  vault_kms_key_arn = dependency.backups_kms.outputs.key_arn
  plan_name         = "afs-backup-plan"
  rules = [
    {
      name              = "daily-backup-rule"
      schedule          = "cron(0 12 * * ? *)"
      start_window      = "65"
      completion_window = "180"
      recovery_point_tags = {
        Project = "AFS-Backup"
        Region  = "me-south-1"
      }
      lifecycle = {
        cold_storage_after = 0
        delete_after       = 10
      }
    }
  ]
  selection_name = "afs-backup-by-tag"
  selection_tags = [
    {
      type  = "STRINGEQUALS"
      key   = "BACKUP_ENABLED"
      value = "true"
    }
  ]
}
