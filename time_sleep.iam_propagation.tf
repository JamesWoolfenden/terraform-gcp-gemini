# IAM grants return before they propagate; creating the CMEK index straight
# after the key grant can fail on the first apply.
resource "time_sleep" "iam_propagation" {
  count = local.create_index ? 1 : 0

  create_duration = "60s"

  depends_on = [google_kms_crypto_key_iam_member.gemini]
}
