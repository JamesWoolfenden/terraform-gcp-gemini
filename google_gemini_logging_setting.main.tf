resource "google_gemini_logging_setting" "main" {
  logging_setting_id        = var.logging_setting_id
  location                  = "global"
  log_prompts_and_responses = var.log_prompts_and_responses
  log_metadata              = var.log_metadata
  labels                    = var.labels
}
