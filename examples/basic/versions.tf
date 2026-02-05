# examples/basic/versions.tf

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
