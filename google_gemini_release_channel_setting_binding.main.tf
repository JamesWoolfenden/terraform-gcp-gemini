resource "google_gemini_release_channel_setting_binding" "main" {
  for_each = toset(var.release_channel_products)

  release_channel_setting_id = google_gemini_release_channel_setting.main.release_channel_setting_id
  setting_binding_id         = "${var.release_channel_setting_id}-${lower(replace(each.key, "_", "-"))}"
  location                   = "global"
  target                     = local.binding_target
  product                    = each.key
  labels                     = var.labels
}
