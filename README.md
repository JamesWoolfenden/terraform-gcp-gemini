# terraform-gcp-gemini

[![Build Status](https://github.com/JamesWoolfenden/terraform-gcp-gemini/workflows/Verify/badge.svg?branch=main)](https://github.com/JamesWoolfenden/terraform-gcp-gemini/actions)
[![Latest Release](https://img.shields.io/github/release/JamesWoolfenden/terraform-gcp-gemini.svg)](https://github.com/JamesWoolfenden/terraform-gcp-gemini/releases/latest)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/tag/JamesWoolfenden/terraform-gcp-gemini.svg?label=latest)](https://github.com/JamesWoolfenden/terraform-gcp-gemini/releases/latest)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D1.5.0-blue.svg)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

Terraform module for Gemini Code Assist / Gemini for Google Cloud administration. It manages the project's Gemini admin settings: a logging setting (prompt/response and metadata logging enabled by default) bound to Gemini Code Assist; a data-sharing-with-Google setting with sharing disabled by default; and a release channel setting (STABLE by default) bound to Gemini Code Assist and Gemini Cloud Assist. Optionally it creates a CMEK-encrypted Gemini Code Assist code repository index (code customization, Enterprise edition) with repository groups of Developer Connect repositories, and grants the key to the Gemini service agent (`service-PROJECT_NUMBER@gcp-sa-cloudaicompanion.iam.gserviceaccount.com`).

## Usage

Add **module.gemini.tf** to your code:-

```terraform
module "gemini" {
  source                   = "jameswoolfenden/gemini/gcp"
  region                   = "us-central1"
  code_repository_index_id = "example-code-index"
  kms_key_name             = google_kms_crypto_key.gemini.id

  repository_groups = {
    "backend" = [{
      resource       = "projects/my-project/locations/us-central1/connections/github/gitRepositoryLinks/backend"
      branch_pattern = "main"
    }]
  }
}
```

See [example/examplea](example/examplea) for a complete working example.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [google_gemini_code_repository_index.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/gemini_code_repository_index) | resource |
| [google_gemini_data_sharing_with_google_setting.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/gemini_data_sharing_with_google_setting) | resource |
| [google_gemini_data_sharing_with_google_setting_binding.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/gemini_data_sharing_with_google_setting_binding) | resource |
| [google_gemini_logging_setting.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/gemini_logging_setting) | resource |
| [google_gemini_logging_setting_binding.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/gemini_logging_setting_binding) | resource |
| [google_gemini_release_channel_setting.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/gemini_release_channel_setting) | resource |
| [google_gemini_release_channel_setting_binding.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/gemini_release_channel_setting_binding) | resource |
| [google_gemini_repository_group.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/gemini_repository_group) | resource |
| [google_kms_crypto_key_iam_member.gemini](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key_iam_member) | resource |
| [google_project.current](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_code_repository_index_id"></a> [code\_repository\_index\_id](#input\_code\_repository\_index\_id) | ID of the Gemini Code Assist code repository index (code customization, Enterprise edition). Null to create no index or repository groups | `string` | `null` | no |
| <a name="input_data_sharing_product"></a> [data\_sharing\_product](#input\_data\_sharing\_product) | Gemini product the data-sharing setting is bound to | `string` | `"GEMINI_CLOUD_ASSIST"` | no |
| <a name="input_data_sharing_setting_id"></a> [data\_sharing\_setting\_id](#input\_data\_sharing\_setting\_id) | ID of the data-sharing-with-Google setting | `string` | `"gemini-data-sharing"` | no |
| <a name="input_enable_data_sharing"></a> [enable\_data\_sharing](#input\_enable\_data\_sharing) | Share prompts and responses with Google to improve GA products. Disabled by default | `bool` | `false` | no |
| <a name="input_enable_preview_data_sharing"></a> [enable\_preview\_data\_sharing](#input\_enable\_preview\_data\_sharing) | Share prompts and responses with Google to improve Preview products. Disabled by default | `bool` | `false` | no |
| <a name="input_kms_key_name"></a> [kms\_key\_name](#input\_kms\_key\_name) | CMEK key used to encrypt the code repository index; must be in the same region as the index. Required when code\_repository\_index\_id is set | `string` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels applied to all Gemini resources for cost allocation and ownership tracking | `map(string)` | `{}` | no |
| <a name="input_log_metadata"></a> [log\_metadata](#input\_log\_metadata) | Log Gemini Code Assist request metadata to Cloud Logging (enabled by default) | `bool` | `true` | no |
| <a name="input_log_prompts_and_responses"></a> [log\_prompts\_and\_responses](#input\_log\_prompts\_and\_responses) | Log Gemini Code Assist prompts and responses to Cloud Logging (enabled by default for audit and investigation) | `bool` | `true` | no |
| <a name="input_logging_setting_id"></a> [logging\_setting\_id](#input\_logging\_setting\_id) | ID of the Gemini logging setting | `string` | `"gemini-logging"` | no |
| <a name="input_region"></a> [region](#input\_region) | Region for the code repository index and repository groups (must be a Gemini Code Assist code customization region, e.g. us-central1 or europe-west1) | `string` | `"us-central1"` | no |
| <a name="input_release_channel"></a> [release\_channel](#input\_release\_channel) | Release channel for Gemini features (STABLE or EXPERIMENTAL) | `string` | `"STABLE"` | no |
| <a name="input_release_channel_products"></a> [release\_channel\_products](#input\_release\_channel\_products) | Gemini products the release channel setting is bound to | `list(string)` | `["GEMINI_CODE_ASSIST", "GEMINI_CLOUD_ASSIST"]` | no |
| <a name="input_release_channel_setting_id"></a> [release\_channel\_setting\_id](#input\_release\_channel\_setting\_id) | ID of the release channel setting | `string` | `"gemini-release-channel"` | no |
| <a name="input_repository_groups"></a> [repository\_groups](#input\_repository\_groups) | Repository groups to index, keyed by repository group ID. Each repository is a Developer Connect git repository link (projects/P/locations/L/connections/C/gitRepositoryLinks/R) and an RE2 branch pattern. Ignored when no index is created | <pre>map(list(object({<br/>        resource       = string<br/>        branch\_pattern = string<br/>      })))</pre> | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_code_repository_index_id"></a> [code\_repository\_index\_id](#output\_code\_repository\_index\_id) | ID of the code repository index, or null when none is created |
| <a name="output_data_sharing_setting_id"></a> [data\_sharing\_setting\_id](#output\_data\_sharing\_setting\_id) | ID of the data-sharing-with-Google setting |
| <a name="output_logging_setting_id"></a> [logging\_setting\_id](#output\_logging\_setting\_id) | ID of the Gemini logging setting |
| <a name="output_release_channel_setting_id"></a> [release\_channel\_setting\_id](#output\_release\_channel\_setting\_id) | ID of the release channel setting |
| <a name="output_repository_group_ids"></a> [repository\_group\_ids](#output\_repository\_group\_ids) | IDs of the repository groups, keyed by repository group ID |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Role and Permissions

<!-- BEGINNING OF PRE-COMMIT-PIKE DOCS HOOK -->
The Terraform resource required is:

```golang
# apply role
resource "google_project_iam_custom_role" "terraform_pike" {
  project     = "pike-477416"
  role_id     = "terraform_pike"
  title       = "terraform_pike"
  description = "A user with least privileges"
  permissions = [
    "cloudaicompanion.codeRepositoryIndexes.create",
    "cloudaicompanion.codeRepositoryIndexes.delete",
    "cloudaicompanion.codeRepositoryIndexes.get",
    "cloudaicompanion.codeRepositoryIndexes.update",
    "cloudaicompanion.dataSharingWithGoogleSettings.create",
    "cloudaicompanion.dataSharingWithGoogleSettings.delete",
    "cloudaicompanion.dataSharingWithGoogleSettings.get",
    "cloudaicompanion.dataSharingWithGoogleSettings.update",
    "cloudaicompanion.loggingSettings.create",
    "cloudaicompanion.loggingSettings.delete",
    "cloudaicompanion.loggingSettings.get",
    "cloudaicompanion.loggingSettings.update",
    "cloudaicompanion.releaseChannelSettings.create",
    "cloudaicompanion.releaseChannelSettings.delete",
    "cloudaicompanion.releaseChannelSettings.get",
    "cloudaicompanion.releaseChannelSettings.update",
    "cloudaicompanion.repositoryGroups.create",
    "cloudaicompanion.repositoryGroups.delete",
    "cloudaicompanion.repositoryGroups.get",
    "cloudaicompanion.repositoryGroups.update",
    "cloudaicompanion.settingBindings.dataSharingWithGoogleSettingsCreate",
    "cloudaicompanion.settingBindings.dataSharingWithGoogleSettingsDelete",
    "cloudaicompanion.settingBindings.dataSharingWithGoogleSettingsGet",
    "cloudaicompanion.settingBindings.dataSharingWithGoogleSettingsUpdate",
    "cloudaicompanion.settingBindings.loggingSettingsCreate",
    "cloudaicompanion.settingBindings.loggingSettingsDelete",
    "cloudaicompanion.settingBindings.loggingSettingsGet",
    "cloudaicompanion.settingBindings.loggingSettingsUpdate",
    "cloudaicompanion.settingBindings.releaseChannelSettingsCreate",
    "cloudaicompanion.settingBindings.releaseChannelSettingsDelete",
    "cloudaicompanion.settingBindings.releaseChannelSettingsGet",
    "cloudaicompanion.settingBindings.releaseChannelSettingsUpdate",
    "cloudkms.cryptoKeys.getIamPolicy",
    "cloudkms.cryptoKeys.setIamPolicy",
    "resourcemanager.projects.get"
  ]
}

# plan role
resource "google_project_iam_custom_role" "terraform_pike_plan" {
  project     = "pike-477416"
  role_id     = "terraform_pike_plan"
  title       = "terraform_pike_plan"
  description = "A user with least privileges"
  permissions = [
    "cloudaicompanion.codeRepositoryIndexes.get",
    "cloudaicompanion.dataSharingWithGoogleSettings.get",
    "cloudaicompanion.loggingSettings.get",
    "cloudaicompanion.releaseChannelSettings.get",
    "cloudaicompanion.repositoryGroups.get",
    "cloudkms.cryptoKeys.getIamPolicy",
    "resourcemanager.projects.get"
  ]
}


```
<!-- END OF PRE-COMMIT-PIKE DOCS HOOK -->

## Help

**Got a question?**

File a GitHub [issue](https://github.com/jameswoolfenden/terraform-gcp-gemini/issues).

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/jameswoolfenden/terraform-gcp-gemini/issues) to report any bugs or file feature requests.

## Copyrights

Copyright © 2026 James Woolfenden

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements. See the NOTICE file
distributed with this work for additional information
regarding copyright ownership. The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at

<https://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied. See the License for the
specific language governing permissions and limitations
under the License.

### Contributors

[![James Woolfenden][jameswoolfenden_avatar]][jameswoolfenden_homepage]<br/>[James Woolfenden][jameswoolfenden_homepage]

[jameswoolfenden_homepage]: https://github.com/jameswoolfenden
[jameswoolfenden_avatar]: https://github.com/jameswoolfenden.png?size=150
