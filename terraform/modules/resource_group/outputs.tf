output "resource_group_details" {
  value = {
    for k, v in azurerm_resource_group.this : k => {
      id   = v.id
      name = v.name
    }
  }
}
