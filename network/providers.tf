provider "aws" {
  region  = "eu-west-1"
  profile = "sandbox"
}

terraform {
  backend "s3" {
    region  = "eu-west-1"
    profile = "sandbox"

    encrypt = true
    bucket  = "temp-terraform-remote-state-storage-s3-kzonov"
    key     = "kzonov/network.tfstate"

    dynamodb_table = "temp-terraform-remote-state-lock-kzonov"
  }
}
