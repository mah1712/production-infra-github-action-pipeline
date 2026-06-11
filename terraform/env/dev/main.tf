# Resource Group Orchestration (dev Environment)

module "resource_group" {
  source = "../../modules/resource_group"
  rg     = var.rg
  tags   = var.tags
}
