resource "google_gemini_data_sharing_with_google_setting" "main" {
  data_sharing_with_google_setting_id = var.data_sharing_setting_id
  location                            = "global"
  enable_data_sharing                 = var.enable_data_sharing
  enable_preview_data_sharing         = var.enable_preview_data_sharing
  labels                              = var.labels
}
