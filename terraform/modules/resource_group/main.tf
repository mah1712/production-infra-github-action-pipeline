resource "azurerm_resource_group" "this" {
  for_each = var.rg

  name     = each.value.name
  location = each.value.location
  
  # Merging Global Tags with Resource-specific Tags
  tags = merge(var.tags, each.value.tags)

  lifecycle {
    # Recommended for production: prevent accidental deletion
    # prevent_destroy = true 
  }
}
