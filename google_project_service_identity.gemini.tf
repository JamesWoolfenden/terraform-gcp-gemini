# The Gemini (Cloud AI Companion) service agent is created lazily. The CMEK
# code repository index needs it granted on the key *before* the index is
# created, so on a fresh project the grant would fail with "service account
# does not exist". Generating the identity up front fixes the ordering.
resource "google_project_service_identity" "gemini" {
  count = local.create_index ? 1 : 0

  provider = google-beta
  project  = data.google_project.current.project_id
  service  = "cloudaicompanion.googleapis.com"
}
