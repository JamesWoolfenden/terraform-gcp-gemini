resource "google_gemini_release_channel_setting" "main" {
  release_channel_setting_id = var.release_channel_setting_id
  location                   = "global"
  release_channel            = var.release_channel
  labels                     = var.labels
}
