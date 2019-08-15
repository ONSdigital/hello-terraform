resource "random_string" "name-prefix" {
  length  = 6
  special = false
}

locals {
  common_tags = module.root_tags.tags

  random_title       = title(random_string.name-prefix.result)
  common_name_prefix = var.common_name != "" ? "${var.common_name}_${local.random_title}" : local.random_title
}


module "root_tags" {
  source    = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.15.0"
  namespace = "es"
  stage     = "dev"
  name      = var.common_name
  attributes = [
  "public"]
  delimiter = "-"

  tags = {
    Team      = "Legacy Uplift"
    ManagedBy = "Terraform"
    App       = "hello-terraform-${local.common_name_prefix}"
  }
}
