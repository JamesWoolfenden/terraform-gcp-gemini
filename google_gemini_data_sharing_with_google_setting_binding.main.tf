resource "google_gemini_data_sharing_with_google_setting_binding" "main" {
  data_sharing_with_google_setting_id = google_gemini_data_sharing_with_google_setting.main.data_sharing_with_google_setting_id
  setting_binding_id                  = "${var.data_sharing_setting_id}-binding"
  location                            = "global"
  target                              = local.binding_target
  product                             = var.data_sharing_product
  labels                              = var.labels
}
