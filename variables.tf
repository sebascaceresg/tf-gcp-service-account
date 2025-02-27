variable "account_description" {
  type        = string
  description = "Description for the service account"
}

variable "account_id" {
  type        = string
  description = "Service account ID"
}

variable "custom_role_description" {
  type        = string
  default     = ""
  description = "Description for the custom role"
}

variable "custom_role_id" {
  type        = string
  default     = ""
  description = "Custom role ID"
}

variable "custom_role_permissions" {
  type        = list(string)
  default     = []
  description = "IAM permissions for the custom role"
}

variable "custom_role_title" {
  type        = string
  default     = ""
  description = "Custom role title"
}

variable "display_name" {
  type        = string
  description = "Display name for the service account"
}

variable "existing_role" {
  type        = string
  default     = ""
  description = "IAM existing role"
}

variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "sa_prefix" {
  type        = string
  description = "Service account prefix for key file"
}
