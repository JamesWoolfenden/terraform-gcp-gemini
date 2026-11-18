resource "google_kms_key_ring" "gemini" {
  name     = "gemini-keyring"
  location = local.region
}
