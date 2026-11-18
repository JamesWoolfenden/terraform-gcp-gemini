# holden:ignore:HLD_TF_026 — examples intentionally use ../../ to reference the local module root
module "gemini" {
  source                   = "../../"
  region                   = local.region
  code_repository_index_id = "example-code-index"
  kms_key_name             = google_kms_crypto_key.gemini.id

  labels = {
    team = "platform"
  }
}
