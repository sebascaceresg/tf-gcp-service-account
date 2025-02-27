output "service_account_email" {
  value = google_service_account.service_account.email
}

output "custom_role_id" {
  value = var.custom_role_id != "" ? google_project_iam_custom_role.custom_role[0].id : ""
}

output "service_account_id" {
  value = google_service_account.service_account.account_id
}
