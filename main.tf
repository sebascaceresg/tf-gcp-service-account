# <---------- Service Account ----------> #
resource "google_service_account" "service_account" {
  project      = var.project_id
  account_id   = var.account_id
  display_name = var.display_name
  description  = var.account_description
}
# <---------- IAM Custom Role ----------> #
resource "google_project_iam_custom_role" "custom_role" {
  count       = var.custom_role_id != "" ? 1 : 0
  role_id     = var.custom_role_id
  title       = var.custom_role_title
  description = var.custom_role_description
  permissions = var.custom_role_permissions
}

resource "google_project_iam_member" "service_account_iam_custom_role" {
  count   = var.custom_role_id != "" ? 1 : 0
  project = var.project_id
  role    = "projects/${var.project_id}/roles/${google_project_iam_custom_role.custom_role[0].role_id}"
  member  = "serviceAccount:${google_service_account.service_account.email}"
}
# <---------- IAM Existing Role ----------> #
resource "google_project_iam_member" "service_account_existing_role" {
  count   = var.existing_role != "" ? 1 : 0
  project = var.project_id
  role    = var.existing_role
  member  = "serviceAccount:${google_service_account.service_account.email}"
}
# <---------- Account Keys to Cloud Storage ----------> #
resource "google_service_account_key" "storage_key" {
  service_account_id = google_service_account.service_account.name
}

resource "google_storage_bucket_object" "account_key_object" {
  provider = google.hub_project
  name     = "service-accounts/keys/${var.project_id}/tf-${var.sa_prefix}-service-key.json"
  bucket   = "tf-hub_bucket-452117"
  content  = base64decode(google_service_account_key.storage_key.private_key)
}

resource "null_resource" "delete_local_key" {
  provisioner "local-exec" {
    command = "rm -rf ${path.module}/sa-key.json"
  }

  depends_on = [google_storage_bucket_object.account_key_object]
}
