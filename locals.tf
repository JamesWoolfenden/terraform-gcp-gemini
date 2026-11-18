locals {
  # The Gemini for Google Cloud (Cloud AI Companion) Service Agent — the
  # identity that encrypts the code repository index with the CMEK key. The
  # grant depends on google_project_service_identity.gemini so it exists first.
  gemini_service_agent = "serviceAccount:service-${data.google_project.current.number}@gcp-sa-cloudaicompanion.iam.gserviceaccount.com"

  # Admin settings are bound to this project.
  binding_target = "projects/${data.google_project.current.number}"

  create_index = var.code_repository_index_id != null
}
