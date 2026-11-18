resource "google_gemini_code_repository_index" "main" {
  count = local.create_index ? 1 : 0

  code_repository_index_id = var.code_repository_index_id
  location                 = var.region
  kms_key                  = var.kms_key_name
  force_destroy            = false
  labels                   = var.labels

  depends_on = [time_sleep.iam_propagation]
}
