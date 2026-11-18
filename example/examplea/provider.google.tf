# holden:ignore:HLD_GCP_059 — per-repo WIF SA with attribute.repository scoping
# provides equivalent least-privilege without impersonation.
provider "google" {
  default_labels = {
    "owner"    = "holden"
    module     = "terraform-gcp-gemini"
    created_by = "terraform"
  }
}

provider "google-beta" {
  default_labels = {
    "owner"    = "holden"
    module     = "terraform-gcp-gemini"
    created_by = "terraform"
  }
}
