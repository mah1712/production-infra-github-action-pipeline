variable "rg" {
  description = "Dynamic map of Resource Groups"
  type = map(object({
    name     = string
    location = string
    tags     = map(string)
  }))

  # PRODUCTION BEST PRACTICE: Naming Convention Validation
  validation {
    condition     = alltrue([for r in var.rg : can(regex("^rg-", r.name))])
    error_message = "Enterprise Policy: All resource group names must start with 'rg-' prefix."
  }
}

variable "tags" {
  description = "Global mandatory tags for compliance"
  type        = map(string)
  default     = {}
}
