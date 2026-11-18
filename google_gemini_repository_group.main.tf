resource "google_gemini_repository_group" "main" {
  for_each = local.create_index ? var.repository_groups : {}

  repository_group_id   = each.key
  location              = var.region
  code_repository_index = google_gemini_code_repository_index.main[0].code_repository_index_id
  labels                = var.labels

  dynamic "repositories" {
    for_each = each.value
    content {
      resource       = repositories.value.resource
      branch_pattern = repositories.value.branch_pattern
    }
  }
}
