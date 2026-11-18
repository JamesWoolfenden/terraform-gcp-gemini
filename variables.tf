variable "region" {
  type        = string
  description = "Region for the code repository index and repository groups (must be a Gemini Code Assist code customization region, e.g. us-central1 or europe-west1)"
  default     = "us-central1"

  validation {
    condition     = length(trimspace(var.region)) > 0
    error_message = "var.region must be a non-empty string"
  }
}

variable "code_repository_index_id" {
  type        = string
  description = "ID of the Gemini Code Assist code repository index (code customization, Enterprise edition). Null to create no index or repository groups"
  default     = null

  validation {
    condition     = var.code_repository_index_id == null || can(regex("^[a-z]([a-z0-9-]{0,61}[a-z0-9])?$", var.code_repository_index_id))
    error_message = "var.code_repository_index_id must be null or 1-63 characters of lowercase letters, numbers and hyphens, starting with a letter"
  }
}

variable "kms_key_name" {
  type        = string
  description = "CMEK key used to encrypt the code repository index; must be in the same region as the index. Required when code_repository_index_id is set"
  default     = null

  validation {
    condition     = var.kms_key_name == null || length(trimspace(coalesce(var.kms_key_name, " "))) > 0
    error_message = "var.kms_key_name must be null or a non-empty string"
  }

  validation {
    condition     = var.code_repository_index_id == null || (var.kms_key_name != null && can(regex("/locations/${var.region}/", coalesce(var.kms_key_name, "-"))))
    error_message = "var.kms_key_name is required when var.code_repository_index_id is set, and must be a KMS key in the same location as var.region"
  }
}

variable "repository_groups" {
  type = map(list(object({
    resource       = string
    branch_pattern = string
  })))
  description = "Repository groups to index, keyed by repository group ID. Each repository is a Developer Connect git repository link (projects/P/locations/L/connections/C/gitRepositoryLinks/R) and an RE2 branch pattern. Ignored when no index is created"
  default     = {}

  validation {
    condition     = alltrue([for k, v in var.repository_groups : can(regex("^[a-z]([a-z0-9-]{0,61}[a-z0-9])?$", k)) && length(v) > 0])
    error_message = "var.repository_groups keys must be lowercase IDs and each group must list at least one repository"
  }

  validation {
    condition     = alltrue(flatten([for k, v in var.repository_groups : [for r in v : can(regex("/gitRepositoryLinks/", r.resource)) && length(trimspace(r.branch_pattern)) > 0]]))
    error_message = "each repository resource must be a Developer Connect gitRepositoryLinks name and branch_pattern must be non-empty"
  }
}

variable "logging_setting_id" {
  type        = string
  description = "ID of the Gemini logging setting"
  default     = "gemini-logging"

  validation {
    condition     = can(regex("^[a-z]([a-z0-9-]{0,40}[a-z0-9])?$", var.logging_setting_id))
    error_message = "var.logging_setting_id must be lowercase letters, numbers and hyphens, starting with a letter"
  }
}

variable "log_prompts_and_responses" {
  type        = bool
  description = "Log Gemini Code Assist prompts and responses to Cloud Logging (enabled by default for audit and investigation)"
  default     = true

  validation {
    condition     = var.log_prompts_and_responses != null
    error_message = "var.log_prompts_and_responses must be true or false"
  }
}

variable "log_metadata" {
  type        = bool
  description = "Log Gemini Code Assist request metadata to Cloud Logging (enabled by default)"
  default     = true

  validation {
    condition     = var.log_metadata != null
    error_message = "var.log_metadata must be true or false"
  }
}

variable "data_sharing_setting_id" {
  type        = string
  description = "ID of the data-sharing-with-Google setting"
  default     = "gemini-data-sharing"

  validation {
    condition     = can(regex("^[a-z]([a-z0-9-]{0,40}[a-z0-9])?$", var.data_sharing_setting_id))
    error_message = "var.data_sharing_setting_id must be lowercase letters, numbers and hyphens, starting with a letter"
  }
}

variable "enable_data_sharing" {
  type        = bool
  description = "Share prompts and responses with Google to improve GA products. Disabled by default"
  default     = false

  validation {
    condition     = var.enable_data_sharing != null
    error_message = "var.enable_data_sharing must be true or false"
  }
}

variable "enable_preview_data_sharing" {
  type        = bool
  description = "Share prompts and responses with Google to improve Preview products. Disabled by default"
  default     = false

  validation {
    condition     = var.enable_preview_data_sharing != null
    error_message = "var.enable_preview_data_sharing must be true or false"
  }
}

variable "data_sharing_product" {
  type        = string
  description = "Gemini product the data-sharing setting is bound to"
  default     = "GEMINI_CLOUD_ASSIST"

  validation {
    condition     = length(trimspace(var.data_sharing_product)) > 0 && upper(var.data_sharing_product) == var.data_sharing_product
    error_message = "var.data_sharing_product must be a non-empty upper-case product name such as GEMINI_CLOUD_ASSIST"
  }
}

variable "release_channel_setting_id" {
  type        = string
  description = "ID of the release channel setting"
  default     = "gemini-release-channel"

  validation {
    condition     = can(regex("^[a-z]([a-z0-9-]{0,40}[a-z0-9])?$", var.release_channel_setting_id))
    error_message = "var.release_channel_setting_id must be lowercase letters, numbers and hyphens, starting with a letter"
  }
}

variable "release_channel" {
  type        = string
  description = "Release channel for Gemini features (STABLE or EXPERIMENTAL)"
  default     = "STABLE"

  validation {
    condition     = contains(["STABLE", "EXPERIMENTAL"], var.release_channel)
    error_message = "var.release_channel must be STABLE or EXPERIMENTAL"
  }
}

variable "release_channel_products" {
  type        = list(string)
  description = "Gemini products the release channel setting is bound to"
  default     = ["GEMINI_CODE_ASSIST", "GEMINI_CLOUD_ASSIST"]

  validation {
    condition     = length(var.release_channel_products) > 0 && alltrue([for p in var.release_channel_products : contains(["GEMINI_CLOUD_ASSIST", "GEMINI_CODE_ASSIST"], p)])
    error_message = "var.release_channel_products must be a non-empty list of GEMINI_CLOUD_ASSIST and/or GEMINI_CODE_ASSIST"
  }
}

variable "labels" {
  type        = map(string)
  description = "Labels applied to all Gemini resources for cost allocation and ownership tracking"
  default     = {}

  validation {
    condition     = alltrue([for k, v in var.labels : can(regex("^[a-z0-9_-]{1,63}$", k)) && can(regex("^[a-z0-9_-]{0,63}$", v))])
    error_message = "var.labels keys and values must be lowercase letters, numbers, underscores, or dashes (GCP label constraints)"
  }
}
