resource "google_kms_crypto_key_iam_member" "gemini" {
  count = local.create_index ? 1 : 0

  crypto_key_id = var.kms_key_name
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = local.gemini_service_agent

  depends_on = [google_project_service_identity.gemini]
}
