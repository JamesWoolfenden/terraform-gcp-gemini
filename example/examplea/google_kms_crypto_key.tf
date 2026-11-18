resource "google_kms_crypto_key" "gemini" {
  name                       = "gemini-code-index-key"
  key_ring                   = google_kms_key_ring.gemini.id
  rotation_period            = "7776000s"
  destroy_scheduled_duration = "2592000s"

  lifecycle {
    prevent_destroy = true
  }
}
