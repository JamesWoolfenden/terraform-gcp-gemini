resource "google_gemini_logging_setting_binding" "main" {
  logging_setting_id = google_gemini_logging_setting.main.logging_setting_id
  setting_binding_id = "${var.logging_setting_id}-binding"
  location           = "global"
  target             = local.binding_target
  product            = "GEMINI_CODE_ASSIST"
  labels             = var.labels
}
