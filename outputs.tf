output "code_repository_index_id" {
  value       = try(google_gemini_code_repository_index.main[0].id, null)
  description = "ID of the code repository index, or null when none is created"
}

output "repository_group_ids" {
  value       = { for k, v in google_gemini_repository_group.main : k => v.id }
  description = "IDs of the repository groups, keyed by repository group ID"
}

output "logging_setting_id" {
  value       = google_gemini_logging_setting.main.id
  description = "ID of the Gemini logging setting"
}

output "data_sharing_setting_id" {
  value       = google_gemini_data_sharing_with_google_setting.main.id
  description = "ID of the data-sharing-with-Google setting"
}

output "release_channel_setting_id" {
  value       = google_gemini_release_channel_setting.main.id
  description = "ID of the release channel setting"
}
