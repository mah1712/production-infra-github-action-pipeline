rg = {
  "app_rg" = {
    name     = "rg-dev-application-001"
    location = "East US"
    tags     = { "Environment" = "Dev" }
  }
}

tags = {
  Environment = "Dev"
  Project     = "Infrastructure-Governance"
  ManagedBy   = "Terraform"
}
