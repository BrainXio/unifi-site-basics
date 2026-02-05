# providers.tf

terraform {
  required_version = ">= 1.5.0" # or ">= 1.6.0", ">= 1.9.0" etc. – pick what you use/test with

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
    unifi = {
      source  = "filipowm/unifi"
      version = "1.0.0" # exact is fine; "~> 1.0" also ok if you want patch updates
    }
  }
}

provider "unifi" {
  api_url        = var.unifi_api_url
  allow_insecure = var.unifi_allow_insecure
  site           = var.unifi_site # usually "default"
  # api_key set via env: export UNIFI_API_KEY=...
}
